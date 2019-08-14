// mapList(mapper)(list)

typedef T Mapper<F, T>(F value);

List<T> Function(List<F>) mapList<F, T>(Mapper<F, T> mapper) =>
    (list) => list.map(mapper).toList();
