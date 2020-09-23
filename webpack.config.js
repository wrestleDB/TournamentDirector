const path = require('path');
const {CleanWebpackPlugin} = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');

module.exports = {
  entry: {
    app: './src/entry.js'
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, './dist')
  },
  plugins: [
    new CleanWebpackPlugin(),
    new VueLoaderPlugin(),
    new HtmlWebpackPlugin({ template: path.resolve(__dirname, './src/index.html') }) //https://github.com/jantimon/html-webpack-plugin/blob/master/docs/template-option.md
  ],
  module: {
    rules: [
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          rootMode: "upward"
        }
      },
      {
        test: /\.vue$/,
        exclude: /node_modules/,
        loader: 'vue-loader',
        exclude: /\.png?$/
      },
      {
        test: /\.coffee$/,
        exclude: /node_modules/,
        loader: 'coffee-loader',
        options: {
          bare: false,
          transpile: {
            presets: ['@babel/env'],
          },
        },
      }
    ]
  }
};
