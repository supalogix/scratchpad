function add_nodes(nodes, node)
{
	return nodes.concat(node);
}

function combine(new_id, parent_node, nodes)
{
	let _id = nodes.reduce((acc,node) => {
		return String.raw`${acc}${node._id}\l`
	}, "");

	const title = nodes.reduce((acc,node) => {
		return node.title
	}, "");

	_id = String.raw`${_id}\l${new_id}`

	const new_node = {
		id: new_id,
		_id,
		title,
		children: []
	}

	nodes.forEach(node => {
		node.children.forEach(child => {
			add_child(new_node, child);
		});
	});

	parent_node.children = [ new_node ];
	new_node.parent_node = parent_node;

	return new_node;
}

function add_child(parent_node, child_node)
{
	child_node.parent_node = parent_node;
	parent_node.children = parent_node.children.concat(child_node)
}

module.exports = {
    add_nodes,
    combine,
    add_child
}