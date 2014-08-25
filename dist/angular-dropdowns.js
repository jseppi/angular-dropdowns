angular.module('ngDropdowns', []).directive('dropdownSelect', [
  'DropdownService', function(DropdownService) {
    return {
      restrict: 'A',
      replace: true,
      scope: {
        dropdownSelect: '=',
        dropdownModel: '=',
        dropdownOnchange: '&'
      },
      controller: [
        '$scope', '$element', '$attrs', function($scope, $element, $attrs) {
          $scope.labelField = $attrs.dropdownItemLabel != null ? $attrs.dropdownItemLabel : 'text';
          DropdownService.register($element);
          this.select = function(selected) {
            if (selected !== $scope.dropdownModel) {
              angular.copy(selected, $scope.dropdownModel);
            }
            $scope.dropdownOnchange({
              selected: selected
            });
          };
          $element.bind('click', function(event) {
            event.stopPropagation();
            DropdownService.toggleActive($element);
          });
          $scope.$on('$destroy', function() {
            DropdownService.unregister($element);
          });
        }
      ],
      template: "<div class='wrap-dd-select'>\n    <span class='selected'>{{dropdownModel[labelField]}}</span>\n    <ul class='dropdown'>\n        <li ng-repeat='item in dropdownSelect'\n            class='dropdown-item'\n            dropdown-select-item='item'\n            dropdown-item-label='labelField'>\n        </li>\n    </ul>\n</div>"
    };
  }
]).directive('dropdownSelectItem', [
  function() {
    return {
      require: '^dropdownSelect',
      replace: true,
      scope: {
        dropdownItemLabel: '=',
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
      template: "<li ng-class='{divider: dropdownSelectItem.divider}'>\n    <a href='' class='dropdown-item'\n        ng-if='!dropdownSelectItem.divider'\n        ng-href='{{dropdownSelectItem.href}}'\n        ng-click='selectItem()'>\n        {{dropdownSelectItem[dropdownItemLabel]}}\n    </a>\n</li>"
    };
  }
]).directive('dropdownMenu', [
  '$parse', '$compile', 'DropdownService', function($parse, $compile, DropdownService) {
    var template;
    template = "<ul class='dropdown'>\n    <li ng-repeat='item in dropdownMenu'\n        class='dropdown-item'\n        dropdown-item-label='labelField'\n        dropdown-menu-item='item'>\n    </li>\n</ul>";
    return {
      restrict: 'A',
      replace: false,
      scope: {
        dropdownMenu: '=',
        dropdownModel: '=',
        dropdownOnchange: '&'
      },
      controller: [
        '$scope', '$element', '$attrs', function($scope, $element, $attrs) {
          var $template, $wrap, tpl;
          $scope.labelField = $attrs.dropdownItemLabel != null ? $attrs.dropdownItemLabel : 'text';
          $template = angular.element(template);
          $template.data('$dropdownMenuController', this);
          tpl = $compile($template)($scope);
          $wrap = angular.element("<div class='wrap-dd-menu'></div>");
          $element.replaceWith($wrap);
          $wrap.append($element);
          $wrap.append(tpl);
          DropdownService.register(tpl);
          this.select = function(selected) {
            if (selected !== $scope.dropdownModel) {
              angular.copy(selected, $scope.dropdownModel);
            }
            $scope.dropdownOnchange({
              selected: selected
            });
          };
          $element.bind("click", function(event) {
            event.stopPropagation();
            DropdownService.toggleActive(tpl);
          });
          $scope.$on('$destroy', function() {
            DropdownService.unregister(tpl);
          });
        }
      ]
    };
  }
]).directive('dropdownMenuItem', [
  function() {
    return {
      require: '^dropdownMenu',
      replace: true,
      scope: {
        dropdownMenuItem: '=',
        dropdownItemLabel: '='
      },
      link: function(scope, element, attrs, dropdownMenuCtrl) {
        scope.selectItem = function() {
          if (scope.dropdownMenuItem.href) {
            return;
          }
          dropdownMenuCtrl.select(scope.dropdownMenuItem);
        };
      },
      template: "<li ng-class='{divider: dropdownMenuItem.divider}'>\n    <a href='' class='dropdown-item'\n        ng-if='!dropdownMenuItem.divider'\n        ng-href='{{dropdownMenuItem.href}}'\n        ng-click='selectItem()'>\n        {{dropdownMenuItem[dropdownItemLabel]}}\n    </a>\n</li>"
    };
  }
]).factory('DropdownService', [
  '$document', function($document) {
    var body, service, _dropdowns;
    service = {};
    _dropdowns = [];
    body = $document.find('body');
    body.bind('click', function() {
      return angular.forEach(_dropdowns, function(el) {
        el.removeClass('active');
      });
    });
    service.register = function(ddEl) {
      _dropdowns.push(ddEl);
    };
    service.unregister = function(ddEl) {
      var index;
      index = _dropdowns.indexOf(ddEl);
      if (index > -1) {
        _dropdowns.splice(index, 1);
      }
    };
    service.toggleActive = function(ddEl) {
      angular.forEach(_dropdowns, function(el) {
        if (el !== ddEl) {
          el.removeClass('active');
        }
      });
      ddEl.toggleClass('active');
    };
    return service;
  }
]);
