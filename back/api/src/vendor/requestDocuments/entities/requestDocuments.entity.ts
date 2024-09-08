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
export class RequestDocuments {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column('varchar', { nullable: false, default: '' })
  documentUrl: string;

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
    (requestPetition) => requestPetition.requestDocuments,
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
