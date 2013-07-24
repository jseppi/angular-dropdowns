angular-dropdowns
=================

Dropdown directives for AngularJS.  

Includes both a select-style dropdown and a menu-style dropdown.  The menu-style dropdown attaches to an existing element (button, link, div, etc), whereas the select-style dropdown replaces the element it is attached to.

See examples for usage: http://jsbin.com/uzicuy/1/

Basically, include 'ngDropdowns' in your module dependencies:

    app = angular.module('app', ['ngDropdowns'])

Then in your controller, setup the select options and currently selected value (optional):

    app.controller('AppCtrl', ($scope) ->
      
        $scope.ddSelectOptions = [
            {
                text: 'Option1'
                iconCls: 'someicon'
            }
            {
                text: 'Option2'
            }
            {
                divider: true
            }  
            {
                text: 'Option4'
                href: '#option4' # Can specify this property for link options
            }                   
        ]  

        $scope.ddSelectSelected = "Select an Option" 
    )
    
And in your html, specify the dropdown-select and dropdown-model attributes on an element:

    <div ng-controller="AppCtrl">
        <div>
            <h1>Dropdown Select</h1>
            <p>You have selected: {{ddSelectSelected}}</p>
            <div dropdown-select="ddSelectOptions" dropdown-model="ddSelectSelected"></div>
        </div>
    </div>
    
-------------

Styling based on http://tympanus.net/codrops/2012/10/04/custom-drop-down-list-styling/
