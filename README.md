# angular-dropdowns

Dropdown directives for AngularJS (1.1.5+, 1.2.x).

Includes both a select-style dropdown and a menu-style dropdown.  The menu-style dropdown attaches to an existing element (button, link, div, etc), whereas the select-style dropdown replaces the element it is attached to.

See examples: http://jsfiddle.net/jseppi/cTzun/53/embedded/result/

## Usage

Include `ngDropdowns` in your module dependencies:

```js
var app = angular.module('app', ['ngDropdowns']);
```

In your controller, setup the select options and object to hold the selected value:

```js
app.controller('AppCtrl', function($scope) {

    // By default the 'text' property will be used as the display text in the dropdown entry.
    // All options that are not dividers must have a 'text' property.
    // Or you can specify a different property name via the dropdown-item-label attribute.
    //
    // If an options object has an 'href' property set, then that dropdown entry
    //   will behave as a link and cannot be selected.
    $scope.ddSelectOptions = [
        {
            text: 'Option1',
            iconCls: 'someicon'
        },
        {
            text: 'Option2',
            someprop: 'somevalue'
        },
        {
            // Any option with divider set to true will be a divider
            // in the menu and cannot be selected.
            divider: true
        },
        {
            // Example of an option with the 'href' property
            text: 'Option4',
            href: '#option4'
        }
    ];

    $scope.ddSelectSelected = {}; // Must be an object
});
```

And in your html, specify the `dropdown-select` and `dropdown-model` attributes on an element.

You can optionally set `dropdown-item-label` to specify a different label field from the default (which is 'text'):

```html
<div ng-controller="AppCtrl">
    <h1>Dropdown Select</h1>
    <p>You have selected: {{ddSelectSelected}}</p>
    <div dropdown-select="ddSelectOptions"
        dropdown-model="ddSelectSelected"
        dropdown-item-label="text" >
    </div>
</div>
```

For a menu-style dropdown, use `dropdown-menu` in place of `dropdown-select`:

```html
<div ng-controller="AppCtrl">
    <h1>Dropdown Select</h1>
    <p>You have selected: {{ddSelectSelected}}</p>
    <a href='' title=''
        dropdown-menu="ddSelectOptions"
        dropdown-model="ddSelectSelected"
        dropdown-item-label="text">
        Menu
    </a>
</div>
```

You can specify a function to call upon dropdown value change by specifying the `dropdown-onchange` attribute. This method will have the selected object passed to it.

```html
<div dropdown-select="ddSelectOptions"
    dropdown-model="ddSelectSelected"
    dropdown-item-label="text"
    dropdown-onchange="someMethod(selected)" >
</div>
```

## Contributors

* [@jseppi](http://github.com/jseppi)
* [@alexisbg](http://github.com/alexisbg)
* [@elishacook](http://github.com/elishacook)
* [@dinodsaurus](https://github.com/dinodsaurus)

## Developing

Pull requests are welcome!

Run `npm install` to get all the development dependencies.

Run `gulp` to build the output files.

## License

[MIT](http://jseppi.mit-license.org/license.html)

## Credits

Styling based on http://tympanus.net/codrops/2012/10/04/custom-drop-down-list-styling/
