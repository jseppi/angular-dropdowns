angular-dropdowns
=================

Dropdown directives for AngularJS (Version 1.1.5).  

Includes both a select-style dropdown and a menu-style dropdown.  The menu-style dropdown attaches to an existing element (button, link, div, etc), whereas the select-style dropdown replaces the element it is attached to.

See examples for usage: http://jsbin.com/uzicuy/1/

Basically, include 'ngDropdowns' in your module dependencies:

    app = angular.module('app', ['ngDropdowns'])

Then in your controller, setup the select options and currently selected value (optional):

    app.controller('AppCtrl', ($scope) ->
      
        # The 'text' property will be used as the display text in the dropdown entry.
        # All options that are not dividers must have a 'text' property.
        # 
        # If an options object has an 'href' property set, then that dropdown entry
        #   will behave as a link and cannot be selected. 
        $scope.ddSelectOptions = [
            {
                text: 'Option1'
                iconCls: 'someicon'
            }
            {
                text: 'Option2'
                someprop: 'somevalue'
            }
            {
                # Any option with divider set to true will be a divider
                # in the menu and cannot be selected.
                divider: true 
            }  
            {
                # Example of an option with the 'href' property
                text: 'Option4'
                href: '#option4' 
            }                   
        ]  

        $scope.ddSelectSelected = {} # Must be an object
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
