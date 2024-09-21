import { ViewColumn, ViewEntity } from 'typeorm';

const query = `
    SELECT
      u.id as value,
      u."firstName" as label
	  FROM public.user AS u
    where 
      u.roles = '{inspector}' and
      u."deletedAt" is null
    `;

@ViewEntity({
  schema: 'public',
  name: 'vw_user_inspector_options',
  expression: query,
})
export class ViewUserInspectorOptions {
  @ViewColumn()
  value: number;

  @ViewColumn()
  label: string;
}
