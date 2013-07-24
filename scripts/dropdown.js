var ngdd;

ngdd = angular.module('ngDropdowns', []);

ngdd.directive('dropdownSelect', function($document) {
  return {
    restrict: 'A',
    replace: true,
    scope: {
      dropdownSelect: '=',
      dropdownModel: '='
    },
    controller: function($scope, $element, $attrs) {
      var body;

      $scope.select = function(text) {
        $scope.dropdownModel = text;
      };
      body = $document.find("body");
      body.bind("click", function() {
        $element.removeClass('active');
      });
      $element.bind('click', function(event) {
        event.stopPropagation();
        $element.toggleClass('active');
      });
    },
    template: "<div class='wrap-dd-select'>\n    <span class='selected'>{{dropdownModel}}</span>\n    <ul class='dropdown'>\n        <li ng-repeat='item in dropdownSelect' \n            ng-class='{divider:item.divider}'\n            ng-switch on='item.divider'>\n            <span ng-switch-when='true'></span>\n            <a ng-switch-default ng-click='select(item.text)' ng-href='{{item.href}}'>\n                <span ng-class='item.iconCls'></span>\n                {{item.text}}\n            </a>\n        </li>\n    </ul>\n</div>"
  };
}).directive('dropdownMenu', function($parse, $compile, $document) {
  var template;

  template = "<ul class='dropdown'>\n    <li ng-repeat='item in dropdownMenu'\n        ng-class='{divider:item.divider}'\n        ng-switch on='item.divider'>\n        <span ng-switch-when='true'></span>\n        <a ng-switch-default ng-click='select(item.text)' ng-href='{{item.href}}'>\n            <span ng-class='item.iconCls'></span>\n            {{item.text}}\n        </a>\n    </li>\n</ul>";
  return {
    restrict: 'A',
    replace: false,
    scope: {
      dropdownMenu: '=',
      dropdownModel: '='
    },
    controller: function($scope, $element, $attrs, $transclude) {
      var $wrap, body, selGetter, tpl;

      selGetter = $parse($attrs.dropdownModel);
      $scope.dropdownModel = selGetter($scope);
      tpl = $compile(template)($scope);
      $wrap = angular.element("<div class='wrap-dd-menu'></div>");
      $element.replaceWith($wrap);
      $wrap.append($element);
      $wrap.append(tpl);
      $scope.select = function(text) {
        $scope.dropdownModel = text;
      };
      body = $document.find("body");
      body.bind("click", function() {
        tpl.removeClass('active');
      });
      $element.bind("click", function(event) {
        event.stopPropagation();
        tpl.toggleClass('active');
      });
    }
  };
});
