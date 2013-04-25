
app = angular.module('app', ['ng-dropdowns'])

app.controller('AppCtrl', ($scope) ->
  
    $scope.dropdown = [
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
            href: '#option4'
        }                   
    ]  

    $scope.blah = "Select an Option" 
)