const CAPYTAL_THEME_NAME = "capytal-dark";

(() => {
	let version = document.querySelector('div.left-links > a[href="/admin/config"]')?.textContent
	if (!version) {
		console.warn(`${CAPYTAL_THEME_NAME}: unable to find Forgejo instance version!`)
		return
	}

	console.debug(`${CAPYTAL_THEME_NAME}: version found ${version}`)

	let style = document.querySelector(`link[href="/assets/css/theme-${CAPYTAL_THEME_NAME}.css?v=${version}"`)
	if (!style) {
		console.warn(`${CAPYTAL_THEME_NAME}: capytal theme not selected, skipping!`)
		return
	}

	console.log(`${CAPYTAL_THEME_NAME}: starting to apply theme modifications`)

	labelStyles()
})()

function labelStyles() {
	/** @type {Element[]} */
	let labels =  [];
	document.querySelectorAll('.labels-list').forEach(e => labels = labels.concat(...e.children))
	document.querySelectorAll('ul.issue-label-list').forEach(e => labels = labels.concat(...e.children))
	document.querySelectorAll('div.filter.menu.ugc-labels').forEach(e => {
		for (let c of e.children) {
			let label = c.querySelector('span.ui.label.scope-parent') ?? c.querySelector('div.ui.label')
			if (label) {
				labels.push(label)
			}
		}
	})

	for (let label of labels) {
		console.log(label)

		let left = label.querySelector('.scope-left')
		let right = label.querySelector('.scope-right')

		if (!left && !right) {
			label = (label.querySelector('div.ui.label')?? label)

			let color = label.getAttribute('style')?.split(' ')?.at(-2)
			label.setAttribute('style', `color: ${color} !important;`+
				`border: solid 1px ${color} !important;`+
				`background-color: ${color.slice(0, -2) + '22'} !important;`)
		}

		if (left) {
			let color = left.getAttribute('style')?.split(' ')?.at(-2)
			left.setAttribute('style', `color: ${color} !important;`+
				`border: solid 1px ${color} !important;`+
				`border-right: solid 0px !important;`+
				`background-color: transparent !important;`)
		}

		if (right) {
			let color = right.getAttribute('style')?.split(' ')?.at(-2)
			right.setAttribute('style', `color: ${color} !important;`+
				`border: solid 1px ${color} !important;`+
				`border-left: solid 0px !important;`+
				`background-color: ${color.slice(0, -2) + '22'} !important;`)
		}
	}

}
