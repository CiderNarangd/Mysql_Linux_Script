use GUILD;
-- �ð����� �������� �޾ƿ��� �������� �Ѵ�.
create table guild_info(
	guild_idx bigint IDENTITY (10000001, 1) NOT NULL Primary key,		-- ��� ������, 10000001���� ����, ��� ù ������ �ش簪 �߱�
	guild_name nvarchar(20) NOT NULL UNIQUE,							-- ����
	guild_master_name nvarchar(20) not null,							-- ����� �̸�
	guild_master_idx bigint not null,									-- ����� ������
	[level] int not null default 1,										-- ��� ����
	[exp] int not null default 0,										-- ��� ����ġ
	guild_points int not null default 0,								-- ��� ����Ʈ
	guild_status tinyint NOT NULL default 0,							-- ��� ���°� ( 0- ������, 1-���� ..)
	comment nvarchar(300),												-- ��� �Ұ���.
	member_cnt int not null default 1,									-- ���� ��
	icon int not null default 0,										-- ��� ������
	created_date DATETIME not null default getdate(),					-- ��� ���� �ð�
	updated_date datetime not null default getdate()					-- ��� ���� ���� �ð�
);

create table guild_member(
	guild_idx bigint not null,											-- ��� ������
	user_idx bigint not null,											-- ���� ���� ��
	[user_name] nvarchar(20) not null,									-- ���� �̸�
	member_grade int not null default 0,								-- ���� ��� (0-����, 1-������, 2-�����)
	contribution_point int not null,									-- �⿩��
	created_date datetime not null default getdate(),					-- ������
	last_login_date datetime ,											-- ������ ���� �ð�
	update_date datetime not null default getdate(),					-- ���� ���� ����ð�
	CONSTRAINT pk_guild_member primary key (guild_idx, user_idx)	
);

create table guild_join_request(
	seq_key bigint not null IDENTITY (1, 1) Primary key,				-- seq_key
	guild_idx bigint not null,											-- ��û�� ���id					--�ε���
	user_idx bigint not null,											-- ��û�� ����idx				--�ε���
	[status] tinyint not null,											-- 0-��û��, 1-����, 2-����
	created_date datetime not null default getdate(),					-- ��û �ð�
	updated_date datetime not null default getdate()					-- ó�� �ð�
)
CREATE INDEX IX_request_gidx ON guild_join_request (guild_idx);
CREATE INDEX IX_request_uidx ON guild_join_request (user_idx);
CREATE UNIQUE INDEX IX_request_guidx ON guild_join_request (guild_idx,user_idx);
