import { IsPositive } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { TypesRol } from 'src/common/glob/types';
import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';

@Entity()
export class User {
  @PrimaryGeneratedColumn('increment')
  @IsPositive()
  id: number;

  @Column('text')
  firstName: string;

  @Column('text')
  paternalName: string;

  @Column('text')
  maternalName: string;

  @Column('text', { unique: true })
  email: string;

  @Column('text', { nullable: true })
  phone: string;

  @Column('text', { nullable: true })
  cellphone: string;

  @Column('text', { select: false })
  password: string;

  @Column('text', { default: '', nullable: true })
  image: string;

  @Column('text', { array: true, default: [TypesRol.admin] })
  roles: string[];

  @Column('text', { default: '', nullable: true })
  address: string;

  @Column('text', { default: '', nullable: true })
  professionalTitle: string;

  @Column('text', { default: '', nullable: true })
  professionalTitleFile: string;

  @Column('text', { default: '', nullable: true })
  cv: string;

  @Column('date', { nullable: true })
  incomeDate: Date;

  @Column('date', { nullable: true })
  conclusionDate: Date;

  @OneToMany(() => RequestPetition, (request) => request.inspector, {
    cascade: true,
    eager: false,
  })
  requests?: RequestPetition[];

  @CreateDateColumn({ type: 'timestamptz', default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamptz', onUpdate: 'CURRENT_TIMESTAMP' })
  updatedAt: Date;

  @DeleteDateColumn({
    nullable: true,
    type: 'timestamptz',
  })
  deletedAt: Date;
}
