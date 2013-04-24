
app = angular.module('app', ['ng-dropdowns'])

app.controller('AppCtrl', ($scope) ->
  
    $scope.dropdown = [
        {
            text: 'Option1'
            click: 'blah()'
            iconCls: 'someicon'
        }
        {
            text: 'Option2'
            href: 'whatever'
        }
        {
            divider: true
            text: 'don\'t show'
        }  
        {
            text: 'Option4'
            href: 'whatever'
        }                   
    ]  

    $scope.blah = "huh" 
)