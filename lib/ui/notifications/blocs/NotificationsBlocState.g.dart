// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationsBlocState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationsBlocState extends NotificationsBlocState {
  @override
  final List<ResponseNotificationItem> suggestions;
  @override
  final bool loading;
  @override
  final int pageNo;
  @override
  final int totalItems;

  factory _$NotificationsBlocState(
          [void Function(NotificationsBlocStateBuilder) updates]) =>
      (new NotificationsBlocStateBuilder()..update(updates)).build();

  _$NotificationsBlocState._(
      {this.suggestions, this.loading, this.pageNo, this.totalItems})
      : super._() {
    if (suggestions == null) {
      throw new BuiltValueNullFieldError(
          'NotificationsBlocState', 'suggestions');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('NotificationsBlocState', 'loading');
    }
    if (pageNo == null) {
      throw new BuiltValueNullFieldError('NotificationsBlocState', 'pageNo');
    }
    if (totalItems == null) {
      throw new BuiltValueNullFieldError(
          'NotificationsBlocState', 'totalItems');
    }
  }

  @override
  NotificationsBlocState rebuild(
          void Function(NotificationsBlocStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationsBlocStateBuilder toBuilder() =>
      new NotificationsBlocStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationsBlocState &&
        suggestions == other.suggestions &&
        loading == other.loading &&
        pageNo == other.pageNo &&
        totalItems == other.totalItems;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, suggestions.hashCode), loading.hashCode),
            pageNo.hashCode),
        totalItems.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NotificationsBlocState')
          ..add('suggestions', suggestions)
          ..add('loading', loading)
          ..add('pageNo', pageNo)
          ..add('totalItems', totalItems))
        .toString();
  }
}

class NotificationsBlocStateBuilder
    implements Builder<NotificationsBlocState, NotificationsBlocStateBuilder> {
  _$NotificationsBlocState _$v;

  List<ResponseNotificationItem> _suggestions;

  List<ResponseNotificationItem> get suggestions => _$this._suggestions;

  set suggestions(List<ResponseNotificationItem> suggestions) =>
      _$this._suggestions = suggestions;

  bool _loading;

  bool get loading => _$this._loading;

  set loading(bool loading) => _$this._loading = loading;

  int _pageNo;

  int get pageNo => _$this._pageNo;

  set pageNo(int pageNo) => _$this._pageNo = pageNo;

  int _totalItems;

  int get totalItems => _$this._totalItems;

  set totalItems(int totalItems) => _$this._totalItems = totalItems;

  NotificationsBlocStateBuilder();

  NotificationsBlocStateBuilder get _$this {
    if (_$v != null) {
      _suggestions = _$v.suggestions;
      _loading = _$v.loading;
      _pageNo = _$v.pageNo;
      _totalItems = _$v.totalItems;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationsBlocState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NotificationsBlocState;
  }

  @override
  void update(void Function(NotificationsBlocStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NotificationsBlocState build() {
    final _$result = _$v ??
        new _$NotificationsBlocState._(
            suggestions: suggestions,
            loading: loading,
            pageNo: pageNo,
            totalItems: totalItems);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
