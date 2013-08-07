
app = angular.module('app', ['ngDropdowns'])

app.controller('AppCtrl', ($scope) ->
  
    $scope.ddSelectOptions = [
        {
            text: 'Option1'
            value: 'one'
            iconCls: 'someicon'
        }
        {
            text: 'Option2'
            someprop: 'somevalue'
        }
        {
            divider: true
        }  
        {
            text: 'Option4'
            href: '#option4'
        }                   
    ]  

    $scope.ddSelectSelected = {
        text: "Select an Option"
    } 
    
    $scope.ddMenuOptions = [
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
            text: 'A link'
            href: '#option4'
        }
    ]  

    $scope.ddMenuSelected = {} 

    $scope.ddMenuOptions2 = [
        {
            name: 'Option2-1 Name'
            iconCls: 'someicon'
        }
        {
            name: 'Option2-2 Name'
        }
        {
            divider: true
        }  
        {
            name: 'A link'
            href: '#option2-4'
        }
    ]  

    $scope.ddMenuSelected2 = {}

    $scope.ddMenuOptions3 = [
        {
            text: 'Option3-1'
            iconCls: 'someicon'
        }
        {
            text: 'Option3-2'
        }
        {
            divider: true
        }  
        {
            text: 'A link'
            href: '#option3-4'
        }
    ]  

    $scope.ddMenuSelected3 = {}
)