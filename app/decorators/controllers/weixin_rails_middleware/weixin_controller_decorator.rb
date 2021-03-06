# encoding: utf-8
# 1, @weixin_message: 获取微信所有参数.
# 2, @weixin_public_account: 如果配置了public_account_class选项,则会返回当前实例,否则返回nil.
# 3, @keyword: 目前微信只有这三种情况存在关键字: 文本消息, 事件推送, 接收语音识别结果
WeixinRailsMiddleware::WeixinController.class_eval do
  include Rails.application.routes.url_helpers

  def reply
    render xml: send("response_#{@weixin_message.MsgType}_message", {})
  end


  def server_path
    "http://ziyougou.newnil.com"
  end
  
  
  
  private

    def response_text_message(options={})
      reply_text_message("Your Message: #{@keyword}")
    end

    # <Location_X>23.134521</Location_X>
    # <Location_Y>113.358803</Location_Y>
    # <Scale>20</Scale>
    # <Label><![CDATA[位置信息]]></Label>
    def response_location_message(options={})
      @lx    = @weixin_message.Location_X
      @ly    = @weixin_message.Location_Y
      @scale = @weixin_message.Scale
      @label = @weixin_message.Label
      reply_text_message("Your Location: #{@lx}, #{@ly}, #{@scale}, #{@label}")
    end

    # <PicUrl><![CDATA[this is a url]]></PicUrl>
    # <MediaId><![CDATA[media_id]]></MediaId>
    def response_image_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      @pic_url  = @weixin_message.PicUrl  # 也可以直接通过此链接下载图片, 建议使用carrierwave.
      reply_image_message(generate_image(@media_id))
    end

    # <Title><![CDATA[公众平台官网链接]]></Title>
    # <Description><![CDATA[公众平台官网链接]]></Description>
    # <Url><![CDATA[url]]></Url>
    def response_link_message(options={})
      @title = @weixin_message.Title
      @desc  = @weixin_message.Description
      @url   = @weixin_message.Url
      reply_text_message("回复链接信息")
    end

    # <MediaId><![CDATA[media_id]]></MediaId>
    # <Format><![CDATA[Format]]></Format>
    def response_voice_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      @format   = @weixin_message.Format
      # 如果开启了语音翻译功能，@keyword则为翻译的结果
      # reply_text_message("回复语音信息: #{@keyword}")
      reply_voice_message(generate_voice(@media_id))
    end

    # <MediaId><![CDATA[media_id]]></MediaId>
    # <ThumbMediaId><![CDATA[thumb_media_id]]></ThumbMediaId>
    def response_video_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      # 视频消息缩略图的媒体id，可以调用多媒体文件下载接口拉取数据。
      @thumb_media_id = @weixin_message.ThumbMediaId
      reply_text_message("回复视频信息")
    end

    def response_event_message(options={})
      event_type = @weixin_message.Event
      send("reply_#{event_type.downcase}_event")
    end

    private

      # 关注公众账号
      def reply_subscribe_event
        if @keyword.present?
          # 扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送
          return reply_text_message("扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送, keyword: #{@keyword}")
        end
        reply_text_message("欢迎关注自由购物帮微信账号")
      end

      # 取消关注
      def reply_unsubscribe_event
        Rails.logger.info("取消关注")
      end

      # 扫描带参数二维码事件: 2. 用户已关注时的事件推送
      def reply_scan_event
        reply_text_message("扫描带参数二维码事件: 2. 用户已关注时的事件推送, keyword: #{@keyword}")
      end

      def reply_location_event # 上报地理位置事件
        @lat = @weixin_message.Latitude
        @lgt = @weixin_message.Longitude
        @precision = @weixin_message.Precision
        reply_text_message("Your Location: #{@lat}, #{@lgt}, #{@precision}")
      end

      # 点击菜单拉取消息时的事件推送
      def reply_click_event
        Rails.logger.info("点击了: #{@keyword}")
        
        if @keyword == "BUTTON_1_2"
          @recommend_events = RecommendEvent.all.order("id desc").limit(10)
          
          arts = []
          @recommend_events.each do |event|
            cover_url = event.cover.nil? ? "" : "#{server_path}#{event.cover_url}"
            link_url = mobile_recommend_event_url(event)
            logger.debug("link is #{link_url} and  cover is #{cover_url}")
            art = generate_article("#{event.title}", "#{event.brief}", "#{cover_url}",link_url)
            arts << art
          end

          if arts.any?
            return reply_news_message(arts)
          else
            return ""
          end
          
        elsif @keyword == "BUTTON_2_1"
          @setting = Setting.where(:key=>"BANGZHUJIESHAO")        
          if @setting.first
            reply_text_message(@setting.first.value)
          else
            return ""
          end
        elsif @keyword == "BUTTON_3_2"
          open_id = @weixin_message.FromUserName
          @user = User.find_by(:open_id=>open_id)
          if @user
            @discount_codes = @user.discount_codes
            
            if @discount_codes.empty?
              reply_text_message("暂无任何优惠券")
            else
              arts = []
              @discount_codes.each do |code|
                image_url = ""
                if code.public_code?
                  image_url = code.try(:discount_event).try(:ticket_image_url)
                else
                  image_url = code.image_url
                end
                
                image_url = "#{server_path}#{image_url}"
                link_url = mobile_discount_code_url(code)
                logger.debug("link is #{link_url} and  cover is #{image_url}")
                art = generate_article("#{code.try(:discount_event).try(:name)}", "#{code.try(:discount_event).try(:intro)}", "#{image_url}",link_url)
                arts << art
              end
              return reply_news_message(arts)
            end
          else
            return reply_text_message("您未绑定登陆过自游购物帮平台,请在点击上方逐注册/登陆菜单后,再查看小帮优惠券")
          end
        else
          return ""
        end
        
      end

      # 点击菜单跳转链接时的事件推送
      def reply_view_event
        Rails.logger.info("你点击了: #{@keyword}")
      end

end
