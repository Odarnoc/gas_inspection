import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';
import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity()
export class RequestMaterials {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column('varchar', { nullable: false })
  material: string;

  @Column('integer', { nullable: false })
  quantity: number;

  @CreateDateColumn({
    type: 'timestamptz',
    default: () => 'CURRENT_TIMESTAMP',
  })
  createdAt: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
    default: () => 'CURRENT_TIMESTAMP',
  })
  updatedAt: Date;

  @ManyToOne(
    () => RequestPetition,
    (requestPetition) => requestPetition.requestMaterials,
    {
      onDelete: 'SET NULL',
    },
  )
  requestPetition: RequestPetition;

  @DeleteDateColumn({
    nullable: true,
    type: 'timestamptz',
  })
  deletedAt: Date;
}
