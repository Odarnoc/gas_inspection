import { ViewColumn, ViewEntity } from 'typeorm';

const query = `
    SELECT
      u.id as value,
      u."firstName" as label
	  FROM public.user AS u
    where 
      u.roles = '{instalator}' and
      u."deletedAt" is null
    `;

@ViewEntity({
  schema: 'public',
  name: 'vw_user_instalator_options',
  expression: query,
})
export class ViewUserInstalatorOptions {
  @ViewColumn()
  value: number;

  @ViewColumn()
  label: string;
}
