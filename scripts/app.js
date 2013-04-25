var app;

app = angular.module('app', ['ngDropdowns']);

app.controller('AppCtrl', function($scope) {
  $scope.ddSelectOptions = [
    {
      text: 'Option1',
      iconCls: 'someicon'
    }, {
      text: 'Option2'
    }, {
      divider: true
    }, {
      text: 'Option4',
      href: '#option4'
    }
  ];
  $scope.ddSelectSelected = "Select an Option";
  $scope.ddMenuOptions = [
    {
      text: 'Option1',
      iconCls: 'someicon'
    }, {
      text: 'Option2'
    }, {
      divider: true
    }, {
      text: 'Option4',
      href: '#option4'
    }
  ];
  $scope.ddMenuSelected = "";
  $scope.ddMenuOptions2 = [
    {
      text: 'Option2-1',
      iconCls: 'someicon'
    }, {
      text: 'Option2-2'
    }, {
      divider: true
    }, {
      text: 'Option2-4',
      href: '#option2-4'
    }
  ];
  $scope.ddMenuSelected2 = "";
  $scope.ddMenuOptions3 = [
    {
      text: 'Option3-1',
      iconCls: 'someicon'
    }, {
      text: 'Option3-2'
    }, {
      divider: true
    }, {
      text: 'Option3-4',
      href: '#option3-4'
    }
  ];
  return $scope.ddMenuSelected3 = "";
});
