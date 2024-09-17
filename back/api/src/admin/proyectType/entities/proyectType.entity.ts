import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  DeleteDateColumn,
  OneToMany,
} from 'typeorm';

@Entity()
export class ProyectType {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column('text', { nullable: true })
  name: string;

  @Column('text', { nullable: true })
  details: string;

  @OneToMany(() => RequestPetition, (request) => request.proyectType, {
    cascade: true,
    eager: false,
  })
  requests?: RequestPetition[];

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
