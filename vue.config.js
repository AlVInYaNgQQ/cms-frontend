const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  configureWebpack: {
    performance: {
      hints: process.env.IS_CLOUD === 'true' ? false: undefined
    }
  }
})
