USE TescoSubscription
Go
/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Table Type:		Reference
	Table Size:		
	Purpose:		To Store the Coupons
	Usage:			Refered by Website for getting Coupon details
	Archiving:		

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	10-June-2013	Abhishek						Adding Column for CampaignID, and foreign key constraint
	23-Jul-2013		Navdeep_Singh					Removing foreign key constraint as part of TFS check in standard
*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NULL
	BEGIN

		CREATE TABLE [Coupon].[Coupon](
			[CouponID] [bigint] IDENTITY(1,1) NOT NULL,
			[CouponCode] [nvarchar](25) NOT NULL,
			[DescriptionShort] [nvarchar](200) NULL,
			[DescriptionLong] [nvarchar](300) NULL,
			[Amount] [money] NOT NULL,
			[RedeemCount] [int] NOT NULL,
			[IsActive] [bit] NOT NULL,
			[UTCCreatedeDateTime] [smalldatetime] NOT NULL,
			[UTCUpdatedDateTime] [smalldatetime] NOT NULL,
			[CampaignID] [bigint] NULL,
		 CONSTRAINT [PK_Coupon] PRIMARY KEY CLUSTERED 
		(
			[CouponID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
		 CONSTRAINT [UQ_Coupon_CouponCode] UNIQUE NONCLUSTERED 
		(
			[CouponCode] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [Coupon].[Coupon] ADD  CONSTRAINT [DF_Coupon_RedeemCount]  DEFAULT ((0)) FOR [RedeemCount]

		ALTER TABLE [Coupon].[Coupon] ADD  CONSTRAINT [DF_Coupon_IsActive]  DEFAULT ((0)) FOR [IsActive]

		ALTER TABLE [Coupon].[Coupon] ADD  CONSTRAINT [DF_Coupon_UTCCreatedeDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedeDateTime]

		ALTER TABLE [Coupon].[Coupon] ADD  CONSTRAINT [DF_Coupon_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]	
	

		IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[Coupon] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[Coupon] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[Coupon] already exists.'
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Coupon' AND TABLE_SCHEMA = 'Coupon'  AND  COLUMN_NAME = 'CampaignID')
		BEGIN			
			ALTER TABLE [Coupon].[Coupon] ADD [CampaignID] [bigint]  NULL;			
			
			IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Coupon' AND TABLE_SCHEMA = 'Coupon'  AND  COLUMN_NAME = 'CampaignID')
			BEGIN				
				PRINT 'SUCCESS - Column [CampaignID] added in Table [Coupon].[Coupon].'
			END
			ELSE
			BEGIN
				RAISERROR('FAIL - Column [CampaignID] not added in Table [Coupon].[Coupon].',16,1)
			END
		END
		ELSE
		BEGIN
			PRINT 'EXISTS - Column [CampaignID] already exists in Table [Coupon].[Coupon].'
		END	
	END

GO