const path = require("path")
const webpack = require("webpack")
const { StatsWriterPlugin } = require("webpack-stats-plugin")
const Visualizer = require("webpack-visualizer-plugin")
const CleanWebpackPlugin = require("clean-webpack-plugin")
const WebpackBuildNotifierPlugin = require("webpack-build-notifier")
const DashboardPlugin = require("webpack-dashboard/plugin")
const Dashboard = require("webpack-dashboard")
const dashboard = new Dashboard()

module.exports = {
    entry: {
        main: "./src/index.js"
    },
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "bundle.js"
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                include: path.resolve(__dirname, "./"),
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader",
                    options: {
                        babelrc: false,
                        presets: [
                            '@babel/preset-env',
                            '@babel/preset-react'
                        ]
                    }
                },
            }
        ]
    },
    plugins: [
        new StatsWriterPlugin({
            filename: "stats.json'"
        }),
        /**
         * We want to visualize how big our dependencies are
         */
        new Visualizer({
            filename: "./statistics.html"
        }),
        new CleanWebpackPlugin('dist', {}),
        new WebpackBuildNotifierPlugin({
            title: "iBuy Build"
        }),
        // you have to explicitly enable this to make the 
        // dashboard work:
        // https://github.com/webpack/webpack/issues/1151#issuecomment-224217185
        new webpack.HotModuleReplacementPlugin(),
        new DashboardPlugin({
            port: 9000,
            handler: dashboard.setData
        }),
        new webpack.DllReferencePlugin({
            context: path.join(__dirname, "src"),
            manifest: require(path.join(
                __dirname, 
                "./vendor/vendor-manifest.json"))
        })
    ],
    devServer: {
        contentBase: path.join(__dirname, 'dist'),
        historyApiFallback: true,
        port: 9000,
        inline: true,
        quiet: true,
        hot: true,
        open: true
    },
    /**
     * Control what bundle information to display
     */
    stats: {
        all: false,
        modules: true,
        maxModules: 0,
        errors: true,
        warnings: true,
        moduleTrace: true,
        errorDetails: true
    }
};