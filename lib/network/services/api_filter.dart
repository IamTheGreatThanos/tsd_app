///Models
class ApiFilter {
  Map<String, String> filter(List<Filter> filters) {
    Map<String, String> result = {};
    filters.forEach((element) {
      result.addEntries([element.resultFilter()]);
    });
    return result;
  }
}

class Filter {
  final ApiFilters _filter;
  final String _value;
  final String? param;

  Filter(this._filter, this._value, {this.param});

  MapEntry<String, String> resultFilter() {
    if (param != null) {
      if (_filter == ApiFilters.equal) {
        return MapEntry(param!, _value);
      }
      return MapEntry(
          '${param ?? ' '}__' + (map[_filter] ?? 'not implemented filter'),
          _value);
    }
    return MapEntry(map[_filter] ?? 'not implemented filter', _value);
  }

  final Map<ApiFilters, String> map = {
    ApiFilters.contains: 'contains',
    ApiFilters.startWith: 'startwith',
    ApiFilters.endWith: 'endswith',
    ApiFilters.isnull: 'isnull',
    ApiFilters.lessOrEqual: 'lte',
    ApiFilters.less: 'lt',
    ApiFilters.greaterOrEqual: 'gte',
    ApiFilters.greater: 'gt',
    ApiFilters.include: 'include',
    ApiFilters.equal: 'include'
  };
}

enum ApiFilters {
  ///contains in bla bla bla
  contains,
  startWith,
  endWith,
  isnull,
  lessOrEqual,
  less,
  greaterOrEqual,
  greater,
  between,
  include,
  equal
}
