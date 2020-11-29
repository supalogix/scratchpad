const { root, nodes } = require("./index")
const { get_names, get_relationships } = require("../reporter")

get_names(nodes);
get_relationships(root)
