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

      this.select = function(selected) {
        angular.copy(selected, $scope.dropdownModel);
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
    template: "<div class='wrap-dd-select'>\n    <span class='selected'>{{dropdownModel.text}}</span>\n    <ul class='dropdown'>\n        <li ng-repeat='item in dropdownSelect'\n            dropdown-select-item='item'>\n        </li>\n    </ul>\n</div>"
  };
}).directive('dropdownSelectItem', function() {
  return {
    require: '^dropdownSelect',
    replace: true,
    scope: {
      dropdownSelectItem: '='
    },
    link: function(scope, element, attrs, dropdownSelectCtrl) {
      scope.selectItem = function() {
        if (scope.dropdownSelectItem.href) {
          return;
        }
        dropdownSelectCtrl.select(scope.dropdownSelectItem);
      };
    },
    template: "<li ng-class='{divider: dropdownSelectItem.divider}'>\n    <a href='' \n        ng-if='!dropdownSelectItem.divider' \n        ng-href='{{dropdownSelectItem.href}}'\n        ng-click='selectItem()'>\n        {{dropdownSelectItem.text}}\n    </a>\n</li>"
  };
}).directive('dropdownMenu', function($parse, $compile, $document) {
  var template;

  template = "<ul class='dropdown'>\n    <li ng-repeat='item in dropdownMenu'\n        dropdown-menu-item='item'></li>\n    </li>\n</ul>";
  return {
    restrict: 'A',
    replace: false,
    scope: {
      dropdownMenu: '=',
      dropdownModel: '='
    },
    controller: function($scope, $element, $attrs) {
      var $template, $wrap, body, tpl;

      $template = angular.element(template);
      $template.data('$dropdownMenuController', this);
      tpl = $compile($template)($scope);
      $wrap = angular.element("<div class='wrap-dd-menu'></div>");
      $element.replaceWith($wrap);
      $wrap.append($element);
      $wrap.append(tpl);
      this.select = function(selected) {
        angular.copy(selected, $scope.dropdownModel);
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
}).directive('dropdownMenuItem', function() {
  return {
    require: '^dropdownMenu',
    replace: true,
    scope: {
      dropdownMenuItem: '='
    },
    link: function(scope, element, attrs, dropdownMenuCtrl) {
      scope.selectItem = function() {
        if (scope.dropdownMenuItem.href) {
          return;
        }
        dropdownMenuCtrl.select(scope.dropdownMenuItem);
      };
    },
    template: "<li ng-class='{divider: dropdownMenuItem.divider}'>\n    <a href='' \n        ng-if='!dropdownMenuItem.divider' \n        ng-href='{{dropdownMenuItem.href}}'\n        ng-click='selectItem()'>\n        {{dropdownMenuItem.text}}\n    </a>\n</li>"
  };
});
