(function() {
  describe('dropdowns', function() {
    var $compile, $rootScope, expect, should;

    $compile = $rootScope = null;
    expect = chai.expect;
    should = chai.should();
    beforeEach(module('ngDropdowns'));
    beforeEach(inject(function(_$compile_, _$rootScope_) {
      $compile = _$compile_;
      $rootScope = _$rootScope_;
    }));
    return it('should do something', function() {
      return 1..should.equal(1);
    });
  });

}).call(this);
