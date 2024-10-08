import { IsPositive } from 'class-validator';
import { ProyectType } from 'src/admin/proyectType/entities/proyectType.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  DeleteDateColumn,
  ManyToOne,
  Index,
  OneToMany,
} from 'typeorm';

import { Location } from 'src/common/interfaces/location.interface';
import { User } from 'src/auth/entities/user.entity';
import { StatusOrder } from 'src/common/glob/status';
import { RequestDocuments } from 'src/vendor/requestDocuments/entities/requestDocuments.entity';
import { RequestMaterials } from 'src/vendor/requestMaterials/entities/requestMaterials.entity';

@Entity()
export class RequestPetition {
  @PrimaryGeneratedColumn('increment')
  @IsPositive()
  id: number;

  @Column('text')
  firstName: string;

  @Column('text')
  paternalName: string;

  @Column('text')
  maternalName: string;

  @Column('text', { default: '', nullable: true })
  ci: string;

  @Column('text', { nullable: true })
  phone: string;

  @Column('text', { nullable: true })
  cellphone: string;

  @Column('text', { default: '', nullable: true })
  zone: string;

  @Column('text', { default: '', nullable: true })
  avenue: string;

  @Column('text', { default: '', nullable: true })
  street: string;

  @Column('text', { default: '', nullable: true })
  door: string;

  @Column('text', { default: '', nullable: true })
  references: string;

  @Column('smallint', { default: StatusOrder.assigned })
  status: number;

  @Column({
    type: 'point',
    transformer: {
      from: (v) => v,
      to: (v) => `${v.x},${v.y}`,
    },
  })
  @Index({ spatial: true })
  location: Location;

  @Column('text', { default: '', nullable: true })
  identityCard: string;

  @Column('text', { default: '', nullable: true })
  waterBill: string;

  @Column('text', { default: '', nullable: true })
  electricityBill: string;

  @Column('text', { default: '', nullable: true })
  realFolio: string;

  @Column('text', { default: '', nullable: true })
  isometric: string;

  @Column('text', { default: '', nullable: true })
  floorPlan: string;

  @Column('text', { default: '', nullable: true })
  materials: string;

  @Column('bool', { default: false })
  minimumVolume: boolean;

  @Column('bool', { default: false })
  airSupply: boolean;

  @Column('bool', { default: false })
  airOutlet: boolean;

  @Column('bool', { default: false })
  rapidAeration: boolean;

  @Column('bool', { default: false })
  pressureCheck: boolean;

  @Column('bool', { default: false })
  valvuleCheck: boolean;

  @Column('bool', { default: false })
  leakCheck: boolean;

  @Column('bool', { default: false })
  ventilation: boolean;

  @Column('bool', { default: false })
  areaCleaning: boolean;

  @Column('date', { nullable: true })
  startDate: Date;

  @Column('date', { nullable: true })
  limitDate: Date;

  @Column('timestamptz', { nullable: true })
  rejectedDate: Date;

  @Column('timestamptz', { nullable: true })
  finishDate: Date;

  @Column('text', { default: '', nullable: true })
  observations: string;

  @ManyToOne(() => ProyectType, (proyectType) => proyectType.requests, {
    onDelete: 'SET NULL',
  })
  proyectType: ProyectType;

  @ManyToOne(() => User, (user) => user.requestsVendor, {
    onDelete: 'SET NULL',
    nullable: true,
  })
  vendor: User;

  @ManyToOne(() => User, (user) => user.requests, {
    onDelete: 'SET NULL',
    nullable: true,
  })
  inspector: User;

  @ManyToOne(() => User, (user) => user.requestsInstalator, {
    onDelete: 'SET NULL',
    nullable: true,
  })
  instalator: User;

  @OneToMany(
    () => RequestDocuments,
    (requestDocument) => requestDocument.requestPetition,
    {
      cascade: true,
      eager: false,
    },
  )
  requestDocuments?: RequestDocuments[];

  @OneToMany(
    () => RequestDocuments,
    (requestMaterials) => requestMaterials.requestPetition,
    {
      cascade: true,
      eager: false,
    },
  )
  requestMaterials?: RequestMaterials[];

  @CreateDateColumn({
    nullable: true,
    type: 'timestamptz',
    default: () => 'CURRENT_TIMESTAMP',
  })
  createdAt: Date;

  @UpdateDateColumn({
    nullable: true,
    type: 'timestamptz',
    default: () => 'CURRENT_TIMESTAMP',
  })
  updatedAt: Date;

  @DeleteDateColumn({
    nullable: true,
    type: 'timestamptz',
  })
  deletedAt: Date;
}
