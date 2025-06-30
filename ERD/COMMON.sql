use COMMON;
-- 시간값은 서버에서 받아오는 기준으로 한다.
-- 사용자 정보 데이터베이스
-- 접속,결제 관련 및 유저 기준 정보

-- 사용자 정보 테이블 : 유저의 기준 정보
create table user_info(
	user_idx bigint IDENTITY (10000001, 1) NOT NULL Primary key,		-- 유저 고유값, 10000001부터 시작, 유저 첫 진입시 해당값 발급
	[user_name] nvarchar(20) NOT NULL UNIQUE,							-- 유저 닉네임
	country_code char(3) NOT NULL DEFAULT 'zz',							-- 국가코드 (default zz)
	device_name nvarchar(50) NOT NULL DEFAULT 'zz',						-- 사용중인 기기명
	os_version nvarchar(50) NOT NULL default 'zz',						-- 사용중인 기기의 os명
	last_login_date datetime NOT NULL default getdate(),				-- 마지막 로그인 시간
	user_status tinyint NOT NULL default 0,								-- User 상태값 ( 0-기본, 1-정지, 2-휴면 ... )
	is_guest tinyint NOT NULL default 0,								-- guest여부 ( 0-guest, 1-소셜 로그인 연동 )
	created_date DATETIME not null default getdate(),					-- 계정 생성 시간 ( )
	updated_date datetime not null default getdate()					-- 계정 정보 변경 시간
);

-- 로그인 정보 테이블 : 소셜 플랫폼별 로그인 정보 관리
create table login_info
(
	user_idx bigint not null,											-- 유저 고유값
	platform_type tinyint not null,										-- 플랫폼 타입 (0 - Google, 1 - Apple Login, 2 - MS, 3 - 네이버.... )
	access_token nvarchar(300) null,									-- 액세스 토큰
	refresh_token nvarchar(300) null,									-- 리프레시 토큰
	created_date datetime not null default getdate(),					-- 플랫폼 최초 연동 시점
	updated_date datetime not null default getdate(),					-- 해당 로우 변경 시점.
	CONSTRAINT pk_login_user_platform primary key (user_idx, platform_type)	
)

-- 정지된 유저 테이블 : 정지 유저 사유 및 기간 관리
create table block_user_list
(
	user_idx bigint not null primary key,								-- 유저 고유 값
	block_reason tinyint not null,										-- 정지 사유 ( 0 - 비매너 행위, 1 - )
	block_detail_reason nvarchar(500) default null,						-- 상세 사유
	blocked_by nvarchar(30),											-- 정지 주최 ( 운영자, System ... )
	is_active tinyint not null default 1,								-- 정지 활성 여부 ( 0 - 계정 정지 비활성화, 1- 계정 정지 활성화)
	block_start_date datetime not null default '2000-01-01',			-- 정지 시작 시간
	block_end_date datetime not null default '2000-01-01',				-- 정지 만료일
	
)

-- 결제 테이블 : 결제 상태 관리 테이블 (로그 테이블과 별도)
create table billing
(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- 대체 키
	user_idx bigint not null,											-- 유저 고유 값
	platform_type int not null,											-- ( 0 - Google Market, 1 - AppStore, 2 - OneStore....)
	[status] int not null,												-- 결제 상태 (0 - 진행중, 1 - 완료, 2 - 실패 ...)
	product_id int not null,											-- 상품ID
	country_code char(3) NOT NULL DEFAULT 'zz',							-- 국가코드 (default zz)
	amount decimal(10,2) not null,										-- 금액
	currency nvarchar(5) not null default 'zz',							-- 화폐 코드
	receipt nvarchar(300),												-- 영수증
	fail_reason nvarchar(300) default null,								-- 결제 실패 사유
	bill_start_date datetime default getdate(),							-- 결제 시작 시간 
	bill_updated_date datetime ,										-- 결제 상태 변경 시간
	bill_end_date datetime												-- 결제 완료 시간

)

-- 공지 사항 테이블
create table Notice
(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- 대체 키 
	notice_type int not null default 0,									-- 공지 타입 (0 - 일반 , 1 - 긴급...)
	contents text not null default '',									-- 내용
	is_active tinyint not null default 0,								-- 공지 홝성화 여부( 0 - 비활성화, 1- 활성화)
	notice_start_date datetime not null default '2000-01-01',			-- 공지 시작일 
	notice_end_date datetime not null default '2000-01-01',				-- 공지 종료일
)
