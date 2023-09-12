// From https://github.com/JamesBoer/Jinx/blob/f2280a751993a08870bad12d51995e9ab842adf6/Utils/JinxTools/Editor.xaml.cs#L300
Prism.languages.jinx = {
	'comment': [
		/-{3,}[\s\S]*?-{3,}/m,
		/--.*$/m
	],
	'string': {
		greedy: true,
		pattern: /"[^"]*"/m
	},
	'number': /\w*(?<!\w)-?\d*\.?\d+/,
	'keyword': [
		/\b(import|library|is|not|and|or|null|number|integer|boolean|string|external|collection|as|increment|decrement|by|if|else|begin|end|over|until|set|coroutine|loop|from|to|while|function|return|break|type|wait|public|private|readonly)\b/,
		/\b(true|false|null)\b/,
	],
	'operator': /[-+*%^&|#]|\/\/?|<[<=]?|>[>=]?|[=~]=?/,
};
