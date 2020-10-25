const path = require('path');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const HtmlWebpackPlugin      = require('html-webpack-plugin');
const { VueLoaderPlugin }    = require('vue-loader');

module.exports = {
  entry: {
    app: './src/client/entry.js'
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, './lib')
  },
  plugins: [
    new CleanWebpackPlugin(),
    new VueLoaderPlugin(),
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, './src/client/index.html'), //https://github.com/jantimon/html-webpack-plugin/blob/master/docs/template-option.md
      favicon: './public/favicon.ico'
    })
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
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader'
        ]
      },
      {
        test: /\.scss$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
        test: /\.less$/,
        use: [
          'style-loader',
          'css-loader',
          'less-loader'
        ]
      },
      {
        test: /\.(png|svg|eot|woff|woff2|ttf)$/,
        loader: 'file-loader',
        exclude: /node_modules/,
        options: {
          name: '[hash].[ext]'
        }
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
