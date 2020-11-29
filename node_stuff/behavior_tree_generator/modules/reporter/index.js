function get_names(nodes)
{
	nodes.forEach(node => {
		const {
			id, 
			_id,
			title,
		}  = node

		const label = String.raw`!$${id} = '"${title}\l\l${_id}"'`

		console.log(label);

	});
}

function get_relationships(root, parent_node = null)
{
	const isTerminalNode = root.length === 0;

	if(isTerminalNode)
		return

	const isRootNode = parent_node === null;

	if(isRootNode)
	{
		root.forEach(node => {
			const relation = `(*) --> $${node.id}`
			console.log(relation);
			get_relationships(node.children, node);
		});
	}
	else
	{
		root.forEach(node => {
			const relation = `$${parent_node.id} --> $${node.id}`
			console.log(relation);
			get_relationships(node.children, node);
		});
	}
}

module.exports = {
    get_names,
    get_relationships
};