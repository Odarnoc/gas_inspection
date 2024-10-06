export function exportActorsParserMap(items) {
  return items.map((item) => ({
    name: item.firstName + item.paternalName + item.maternalName,
    count: +item.vendor_count + +item.instalator_count + +item.inspector_count,
  }));
}
