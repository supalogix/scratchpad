const path = require("path")
const webpack = require("webpack")
const join = path.join.bind(path, __dirname)

module.exports = {
    entry: {
        vendor: [
            join('vendor', 'vendor.js')
        ]
    },
    output: {
//        path: join('build'),
        path: join('dist'),
        filename: '[name].js',
        library: '[name]'
    },
    plugins: [
        new webpack.DllPlugin({
            path: join('vendor', '[name]-manifest.json'),
            name: '[name]',
            context: join('vendor')
        })
    ],
    resolve: {
        extensions: [
            ".js",
            ".jsx"
        ]
    }
}