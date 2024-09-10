import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

import { User } from 'src/auth/entities/user.entity';

@Entity()
export class RequestPetitionLogs {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column('text')
  eventType: string;

  @Column('text')
  log: string;

  @Column('text')
  result: string;

  @Column('text')
  extraDetails: string;

  @CreateDateColumn({ type: 'timestamptz', default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.requestPetitionLogs, {
    onDelete: 'CASCADE',
    nullable: false,
  })
  user: User;
}
