import { IsPositive } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { TypesRol } from 'src/common/glob/types';

@Entity()
export class User {
  @PrimaryGeneratedColumn('increment')
  @IsPositive()
  id: number;

  @Column('text')
  fistName: string;

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
