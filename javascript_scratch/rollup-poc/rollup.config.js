import resolve from 'rollup-plugin-node-resolve'
import babel from 'rollup-plugin-babel'
import commonJS from 'rollup-plugin-commonjs'
import run from 'rollup-plugin-run';
import autoExternal from 'rollup-plugin-auto-external';


export default {
  input: 'index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'cjs'
  },
//  external: [
//  	 "express"
//  ],
  plugins: [
    resolve({
		 main: true,
		 extensions: [ '.js' ],
		 jsnext: true,
	 	 modulesOnly: true
	 }),
    babel({
      include: 'node_modules/**' // only transpile our source code
    }),
	 commonJS({
      include: 'node_modules/**' 
	 }),
	 run()
  ]
}
