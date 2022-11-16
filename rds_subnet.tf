resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.DatabaseSubnet-1.id, aws_subnet.DatabaseSubnet-2.id]

  tags = {
    Name = "Database subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  multi_az               = true
  name                   = "mydb"
  username               = "ProjectTtn"
  password               = "Project123"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db-sg.id]
}