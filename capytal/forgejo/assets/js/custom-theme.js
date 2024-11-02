/**
 * This is was a attempt to change the icons of the instance. The code works,
 * but finding every single icon takes a lot of work, for little reward.
 *
 * For now this will be unused, until it is completed ~~some day~~.
 */

/**
 * SVG icons source code used below as strings are from the Solar Icon Set,
 * by 480 Design, licensed under the Creative Commons' CC-BY 4.0 license.
 * Source code were accessed via the Iconify API, via the icones.js.org front-end.
 *
 * Original set can be found here:
 * https://www.figma.com/community/file/1166831539721848736/solar-icons-set
 *
 * Collection on icones.js.org can be found here:
 * https://icones.js.org/collection/solar
 */

// solar:bookmark-opened-bold-duotone
const REPO_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" fill-rule="evenodd" d="M3.464 20.536C4.93 22 7.286 22 12 22s7.071 0 8.535-1.465C22 19.072 22 16.714 22 12q.001-1.002-.004-1.867c-.002-.279-.003-.418-.057-.641a1.5 1.5 0 0 0-.152-.421a4.25 4.25 0 0 0-1.857-1.858c-.412-.21-.92-.333-1.707-.397q-.224-.02-.473-.03l-1.5-.034v4.056c0 .496 0 .836-.015 1.09c-.015.262-.043.343-.05.358a.75.75 0 0 1-.862.425c-.016-.004-.097-.032-.315-.18a21 21 0 0 1-.872-.653l-.067-.052c-.37-.285-.659-.507-.973-.644a2.75 2.75 0 0 0-2.192 0c-.314.137-.603.359-.973.644l-.067.052c-.393.303-.663.51-.873.653c-.217.148-.298.176-.314.18a.75.75 0 0 1-.862-.425c-.007-.015-.035-.096-.05-.358a22 22 0 0 1-.015-1.09V6.752l-1.5.033q-.249.012-.473.03c-.787.065-1.295.189-1.706.398A4.25 4.25 0 0 0 2.204 9.09c-.06.12-.09.18-.143.402c-.054.222-.055.362-.057.641Q2 10.999 2 12c0 4.714 0 7.071 1.464 8.535" clip-rule="evenodd" opacity=".6"/><path fill="currentColor" d="M7.75 6.752v4.056c0 .496 0 .836.015 1.09c.015.262.043.343.05.358a.75.75 0 0 0 .862.425c.016-.004.097-.032.314-.18c.21-.143.48-.35.873-.653l.067-.052c.37-.285.659-.507.973-.644a2.75 2.75 0 0 1 2.192 0c.314.137.603.36.973.645l.067.051c.393.303.663.51.873.653c.217.148.298.176.314.18a.75.75 0 0 0 .862-.425c.007-.015.035-.096.05-.358c.015-.254.015-.594.015-1.09V6.752z"/><path fill="currentColor" d="M20.535 3.464C19.071 2 16.714 2 12 2S4.928 2 3.464 3.464c-.77.77-1.134 1.785-1.308 3.26l-.119 2.878q.01-.052.024-.11a1.4 1.4 0 0 1 .143-.402l.01-.02A4.25 4.25 0 0 1 4.07 7.214c.411-.21.919-.333 1.706-.397q.225-.018.473-.03l1.5-.034V10.5h8.5V6.752l1.5.033q.248.014.473.03c.787.065 1.295.189 1.707.398a4.25 4.25 0 0 1 1.857 1.858l.01.019l.046.096V6.723c-.174-1.474-.539-2.49-1.308-3.259M2.002 10.5v-.056L2 10.5z" opacity=".4"/></svg>';

// solar:bookmark-opened-line-duotone
const REPO_TEMPLATE_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M2 12c0-4.714 0-7.071 1.464-8.536C4.93 2 7.286 2 12 2s7.071 0 8.535 1.464C22 4.93 22 7.286 22 12" opacity=".5"/><path d="M14 6h-4c-2.8 0-4.2 0-5.27.545A5 5 0 0 0 2.545 8.73C2 9.8 2 11.2 2 14s0 4.2.545 5.27a5 5 0 0 0 2.185 2.185C5.8 22 7.2 22 10 22h4c2.8 0 4.2 0 5.27-.545a5 5 0 0 0 2.185-2.185C22 18.2 22 16.8 22 14s0-4.2-.545-5.27a5 5 0 0 0-2.185-2.185C18.2 6 16.8 6 14 6Z"/><path d="M17 6v4.808c0 .975 0 1.462-.13 1.753a1.5 1.5 0 0 1-1.724.848c-.31-.075-.695-.372-1.468-.967c-.436-.336-.654-.504-.881-.602a2 2 0 0 0-1.594 0c-.227.098-.445.266-.881.602c-.773.595-1.159.892-1.468.967a1.5 1.5 0 0 1-1.725-.848C7 12.27 7 11.783 7 10.808V6" opacity=".5"/></g></svg>';

// solar:floor-lamp-broken
const REPO_FORK_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" d="M12 18v-1.063a4.14 4.14 0 0 0-1.597-3.272l-3.881-2.774m-3.743-.207l2.532-3.241M2.78 10.684c-.35.448-.274 1.118.26 1.305a3.05 3.05 0 0 0 3.483-1.098m-3.743-.207a2.076 2.076 0 0 1-.34-2.898a2.033 2.033 0 0 1 2.872-.343m0 0c.35-.448 1.013-.53 1.318-.05a3.12 3.12 0 0 1-.107 3.498"/><path stroke-linecap="round" d="M12 18v-1.063c0-1.282.59-2.49 1.597-3.272l3.881-2.774m3.743-.207l-2.532-3.241m2.532 3.241c.35.448.274 1.118-.26 1.305a3.05 3.05 0 0 1-3.483-1.098m3.743-.207a2.076 2.076 0 0 0 .34-2.898a2.033 2.033 0 0 0-2.872-.343m0 0c-.35-.448-1.013-.53-1.318-.05a3.12 3.12 0 0 0 .107 3.498M9 22h6m-3 0v-9m0-6v3"/><path d="M12 7a3 3 0 0 0 2.836-2.018C15.016 4.46 14.552 4 14 4h-4c-.552 0-1.016.46-.836.982A3 3 0 0 0 12 7Zm0-5a2 2 0 0 1 2 2h-4a2 2 0 0 1 2-2Z"/></g></svg>';

// solar:flip-horizontal-bold-duotone
const REPO_MIRROR_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M22 5.887v12.227c0 1.702 0 2.553-.542 2.832c-.543.28-1.235-.215-2.62-1.205l-1.582-1.13c-.616-.439-.924-.659-1.09-.982S16 16.927 16 16.171V7.83c0-.757 0-1.135.166-1.458c.166-.324.474-.543 1.09-.983l1.581-1.13c1.386-.99 2.078-1.484 2.62-1.205c.543.28.543 1.13.543 2.833m-20 0v12.227c0 1.702 0 2.553.542 2.832c.543.28 1.235-.215 2.62-1.205l1.582-1.13c.616-.439.924-.659 1.09-.982S8 16.927 8 16.171V7.83c0-.757 0-1.135-.166-1.458c-.166-.324-.474-.543-1.09-.983l-1.582-1.13c-1.385-.99-2.077-1.484-2.62-1.205C2 3.334 2 4.184 2 5.887" opacity=".5"/><path fill="currentColor" fill-rule="evenodd" d="M12 22.75a.75.75 0 0 1-.75-.75v-4a.75.75 0 0 1 1.5 0v4a.75.75 0 0 1-.75.75m0-8a.75.75 0 0 1-.75-.75v-4a.75.75 0 0 1 1.5 0v4a.75.75 0 0 1-.75.75m0-8a.75.75 0 0 1-.75-.75V2a.75.75 0 0 1 1.5 0v4a.75.75 0 0 1-.75.75" clip-rule="evenodd"/></svg>';

// solar:lock-unlocked-bold-duotone
const LOCK_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M2 16c0-2.828 0-4.243.879-5.121C3.757 10 5.172 10 8 10h8c2.828 0 4.243 0 5.121.879C22 11.757 22 13.172 22 16s0 4.243-.879 5.121C20.243 22 18.828 22 16 22H8c-2.828 0-4.243 0-5.121-.879C2 20.243 2 18.828 2 16" opacity=".5"/><path fill="currentColor" d="M6.75 8a5.25 5.25 0 0 1 10.335-1.313a.75.75 0 0 0 1.452-.374A6.75 6.75 0 0 0 5.25 8v2.055a24 24 0 0 1 1.5-.051z"/></svg>';

// solar:buildings-bold-duotone
const ORG_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" fill-rule="evenodd" d="M7 5h4c1.886 0 2.828 0 3.414.586S15 7.114 15 9v12.25h7a.75.75 0 0 1 0 1.5H2a.75.75 0 0 1 0-1.5h1V9c0-1.886 0-2.828.586-3.414S5.114 5 7 5M5.25 8A.75.75 0 0 1 6 7.25h6a.75.75 0 0 1 0 1.5H6A.75.75 0 0 1 5.25 8m0 3a.75.75 0 0 1 .75-.75h6a.75.75 0 0 1 0 1.5H6a.75.75 0 0 1-.75-.75m0 3a.75.75 0 0 1 .75-.75h6a.75.75 0 0 1 0 1.5H6a.75.75 0 0 1-.75-.75M9 18.25a.75.75 0 0 1 .75.75v2.25h-1.5V19a.75.75 0 0 1 .75-.75" clip-rule="evenodd"/><path fill="currentColor" d="M15 2h2c1.886 0 2.828 0 3.414.586S21 4.114 21 6v15.25h-6V9c0-1.886 0-2.828-.586-3.414C13.842 5.013 12.928 5 11.126 5V3.5c.084-.387.225-.68.46-.914C12.17 2 13.114 2 15 2" opacity=".5"/></svg>';

// solar:bookmark-circle-line-duotone
const COMMIT_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M16 14.046v-2.497c0-2.145 0-3.217-.586-3.883S13.886 7 12 7s-2.828 0-3.414.666S8 9.404 8 11.55v2.497c0 1.548 0 2.322.326 2.66a.95.95 0 0 0 .562.29c.438.056.95-.453 1.975-1.473c.453-.45.68-.676.942-.735a.9.9 0 0 1 .39 0c.262.059.489.284.942.735c1.024 1.02 1.537 1.53 1.976 1.473a.95.95 0 0 0 .56-.29c.327-.338.327-1.112.327-2.66Z"/><path d="M22 12c0 5.523-4.477 10-10 10S2 17.523 2 12S6.477 2 12 2s10 4.477 10 10Z" opacity=".5"/></g></svg>';

// solar:minus-circle-line-duotone
const ISSUE_OPENED_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="12" r="10" opacity=".5"/><path stroke-linecap="round" d="M15 12H9"/></g></svg>';

// solar:bell-bold-duotone
const BELL_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M18.75 9v.704c0 .845.24 1.671.692 2.374l1.108 1.723c1.011 1.574.239 3.713-1.52 4.21a25.8 25.8 0 0 1-14.06 0c-1.759-.497-2.531-2.636-1.52-4.21l1.108-1.723a4.4 4.4 0 0 0 .693-2.374V9c0-3.866 3.022-7 6.749-7s6.75 3.134 6.75 7" opacity=".5"/><path fill="currentColor" d="M7.243 18.545a5.002 5.002 0 0 0 9.513 0c-3.145.59-6.367.59-9.513 0"/></svg>';

// solar:hamburger-menu-broken
const MENU_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-width="1.5" d="M4 7h3m13 0h-9m9 10h-3M4 17h9m-9-5h16"/></svg>';

// solar:filter-bold-duotone
const MENU_FILTERS_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" fill-rule="evenodd" d="M5 3h14L8.816 13.184a2.7 2.7 0 0 0-.778-1.086c-.228-.198-.547-.377-1.183-.736l-2.913-1.64c-.949-.533-1.423-.8-1.682-1.23C2 8.061 2 7.541 2 6.503v-.69c0-1.326 0-1.99.44-2.402C2.878 3 3.585 3 5 3" clip-rule="evenodd"/><path fill="currentColor" d="M22 6.504v-.69c0-1.326 0-1.99-.44-2.402C21.122 3 20.415 3 19 3L8.815 13.184q.075.193.121.403c.064.285.064.619.064 1.286v2.67c0 .909 0 1.364.252 1.718c.252.355.7.53 1.594.88c1.879.734 2.818 1.101 3.486.683S15 19.452 15 17.542v-2.67c0-.666 0-1 .063-1.285a2.68 2.68 0 0 1 .9-1.49c.227-.197.545-.376 1.182-.735l2.913-1.64c.948-.533 1.423-.8 1.682-1.23c.26-.43.26-.95.26-1.988" opacity=".5"/></svg>';

// solar:menu-dots-bold
const MENU_DOTS_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M7 12a2 2 0 1 1-4 0a2 2 0 0 1 4 0m7 0a2 2 0 1 1-4 0a2 2 0 0 1 4 0m7 0a2 2 0 1 1-4 0a2 2 0 0 1 4 0"/></svg>';

// solar:add-circle-bold-duotone
const PLUS_ICON = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M22 12c0 5.523-4.477 10-10 10S2 17.523 2 12S6.477 2 12 2s10 4.477 10 10" opacity=".5"/><path fill="currentColor" d="M12.75 9a.75.75 0 0 0-1.5 0v2.25H9a.75.75 0 0 0 0 1.5h2.25V15a.75.75 0 0 0 1.5 0v-2.25H15a.75.75 0 0 0 0-1.5h-2.25z"/></svg>';

// solar:alt-arrow-right-bold
const ARROW_RIGHT = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M15.835 11.63L9.205 5.2C8.79 4.799 8 5.042 8 5.57v12.86c0 .528.79.771 1.205.37l6.63-6.43a.5.5 0 0 0 0-.74"/></svg>';

// solar:alt-arrow-left-bold
const ARROW_LEFT = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="m8.165 11.63l6.63-6.43C15.21 4.799 16 5.042 16 5.57v12.86c0 .528-.79.771-1.205.37l-6.63-6.43a.5.5 0 0 1 0-.74"/></svg>';

// solar:double-alt-arrow-right-bold-duotone
const DOUBLE_ARROW_RIGHT = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M6.25 19a.75.75 0 0 0 1.32.488l6-7a.75.75 0 0 0 0-.976l-6-7A.75.75 0 0 0 6.25 5z" opacity=".5"/><path fill="currentColor" fill-rule="evenodd" d="M10.512 19.57a.75.75 0 0 1-.081-1.058L16.012 12l-5.581-6.512a.75.75 0 1 1 1.139-.976l6 7a.75.75 0 0 1 0 .976l-6 7a.75.75 0 0 1-1.058.082" clip-rule="evenodd"/></svg>';

// solar:double-alt-arrow-right-left-duotone
const DOUBLE_ARROW_LEFT = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M17.75 19a.75.75 0 0 1-1.32.488l-6-7a.75.75 0 0 1 0-.976l6-7A.75.75 0 0 1 17.75 5z" opacity=".5"/><path fill="currentColor" fill-rule="evenodd" d="M13.488 19.57a.75.75 0 0 0 .081-1.058L7.988 12l5.581-6.512a.75.75 0 1 0-1.138-.976l-6 7a.75.75 0 0 0 0 .976l6 7a.75.75 0 0 0 1.057.082" clip-rule="evenodd"/></svg>';

const VERSION = document.querySelector('.left-links > a[href="/admin/config"]')?.textContent || "0.0.0";
if (VERSION === '0.0.0') {
	console.warn('[Custom theme] Unable to find Forgejo version')
}

const THEME_ELEM =
	document.querySelector(`link[href="/assets/css/theme-capytal-dark-a.css?v=${VERSION}"]`) ||
	document.querySelector(`link[href="/assets/css/theme-capytal-light-a.css?v=${VERSION}"]`)
if (!THEME_ELEM) {
	console.warn('[Custom theme] Capytal theme element not found')
}

const IS_CAPYTAL_THEME = THEME_ELEM ? true : false;
if (IS_CAPYTAL_THEME) {
	console.log('[Custom theme] Applying changes to Capytal theme')
	main()
} else {
	console.warn('[Custom theme] Not applying custom theme changes');
}

function main() {
	applyChanges();

	setTimeout(() => {
		applyChanges();
	}, 500)
	setTimeout(() => {
		applyChanges();
	}, 1000)
	setTimeout(() => {
		applyChanges();
	}, 2000)
}

function applyChanges() {
	changeIcon('svg.svg.octicon-bell', BELL_ICON)
	changeIcon('svg.svg.octicon-three-bars', MENU_ICON)
	changeIcon('svg.svg.octicon-filter', MENU_FILTERS_ICON)
	changeIcon('svg.svg.octicon-kebab-horizontal', MENU_DOTS_ICON)
	changeIcon('svg.svg.octicon-plus', PLUS_ICON)

	changeIcon('svg.svg.octicon-chevron-right', ARROW_RIGHT)
	changeIcon('svg.svg.octicon-chevron-left', ARROW_LEFT)
	changeIcon('svg.svg.gitea-double-chevron-right', DOUBLE_ARROW_RIGHT)
	changeIcon('svg.svg.gitea-double-chevron-left', DOUBLE_ARROW_LEFT)

	changeIcon('svg.svg.octicon-repo', REPO_ICON)
	changeIcon('svg.svg.octicon-repo-push', REPO_ICON)
	changeIcon('svg.svg.octicon-repo-template', REPO_TEMPLATE_ICON)
	changeIcon('svg.svg.octicon-repo-forked', REPO_FORK_ICON)
	changeIcon('svg.svg.octicon-mirror', REPO_MIRROR_ICON)
	changeIcon('svg.svg.octicon-lock', LOCK_ICON)

	changeIcon('svg.svg.octicon-organization', ORG_ICON)

	changeIcon('svg.svg.octicon-git-commit', COMMIT_ICON)
	changeIcon('svg.svg.octicon-issue-opened', ISSUE_OPENED_ICON)
}

/**
 * @param {string} html - The html to parse
 * @returns {Element} - The resulting element
 */
function parseHTML(html) {
	let el = document.createElement('div');
	el.innerHTML = html;
	return el.children.item(0);
}

/**
 * @param {string} original - CSS selector of the original icon
 * @param {string} newIcon - SVG text for the new icon
 */
function changeIcon(original, newIcon) {
	let originalIcons = document.querySelectorAll(original);
	for (const icon of originalIcons) {
		let newEl = parseHTML(newIcon);

		newEl.setAttribute('width', icon.getAttribute('width') ?? "")
		newEl.setAttribute('height', icon.getAttribute('height') ?? "")
		newEl.setAttribute('class', icon.getAttribute('class') ?? "")

		icon.before(newEl)
		icon.remove()
	}
}
