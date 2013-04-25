var ngdd;

ngdd = angular.module('ngDropdowns', []);

ngdd.directive('dropdownSelect', function() {
  return {
    restrict: 'EA',
    scope: {
      dropdownSelect: '=',
      ddSelected: '='
    },
    transclude: false,
    replace: true,
    controller: function($scope, $element, $attrs) {
      $scope.active = false;
      $scope.toggleActive = function() {
        return $scope.active = !$scope.active;
      };
      $scope.select = function(text) {
        return $scope.ddSelected = text;
      };
    },
    template: "            <div ng-click='toggleActive()' ng-class='{active:active}' class='wrap-dd-select'>                <span class='selected'>{{ddSelected}}</span>                <ul class='dropdown'>                    <li ng-repeat='item in dropdownSelect'                         ng-class='{divider:item.divider}'                        ng-switch on='item.divider'>                        <span ng-switch-when='true'></span>                        <a ng-switch-default ng-click='select(item.text)' ng-href='{{item.href}}'>                            <span ng-class='item.iconCls'></span>                            {{item.text}}                        </a>                    </li>                </ul>            </div>            "
  };
}).directive('dropdownMenu', function($parse, $compile) {
  var buildTemplate;

  buildTemplate = function(items) {
    var a, href, item, ul, _i, _len;

    ul = angular.element("<ul class='dropdown'></ul>");
    for (_i = 0, _len = items.length; _i < _len; _i++) {
      item = items[_i];
      if (item.divider) {
        ul.append("<li class='divider'></li>");
      } else if (item.text) {
        href = item.href != null ? item.href : '';
        a = angular.element("<a href='" + href + "' ng-click='select(\"" + item.text + "\")'>" + item.text + "</a>");
        if (item.iconCls != null) {
          a.prepend("<span class='" + item.iconCls + "'></span>");
        }
        ul.append(angular.element("<li></li>").append(a));
      }
    }
    return ul;
  };
  return {
    restrict: 'A',
    scope: {
      dropdownMenu: '=',
      ddSelected: '='
    },
    controller: function($scope, $element, $attrs) {
      var selGetter, tpl, tplDom, wrap;

      selGetter = $parse($attrs.ddSelected);
      $scope.ddSelected = selGetter($scope);
      $scope.select = function(text) {
        $scope.ddSelected = text;
      };
      tpl = buildTemplate($scope.dropdownMenu);
      tplDom = $compile(tpl)($scope);
      wrap = angular.element("<div class='wrap-dd-menu'></div>");
      $element.replaceWith(wrap);
      wrap.append($element);
      wrap.append(tplDom);
      $element.bind("click", function() {
        $element.parent().toggleClass('active');
      });
    }
  };
});
