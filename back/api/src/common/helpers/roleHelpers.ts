export function hasRoles(admitRoles: string[], userRoles: string[]) {
  if (!userRoles) return false;
  return userRoles.every((value) => {
    return admitRoles.includes(value);
  });
}
