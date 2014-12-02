ChinaSMS.use :yunpian, password: '28edf132fac3af9b66c7646939d8fa9c'

# 通用接口

tpl_params = { code: 123, company: '自游购物帮' }
ChinaSMS.to '18516211114', tpl_params, tpl_id: 1