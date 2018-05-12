/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Table Type:		Reference
	Table Size:		
	Purpose:		Internal table
	Usage:			Not used by system, and it is for Developer purpose
	Fillfactor:		
	Archiving:		N/A

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponAttributesReference]',N'U') IS NULL
	BEGIN

		CREATE TABLE [Coupon].[CouponAttributesReference](
			[AttributeID] [smallint] NOT NULL,
			[Description] [nvarchar](250) NULL,
			[UTCCreatedDateTime] [smalldatetime] NOT NULL,
			[UTCUpdatedDateTime] [smalldatetime] NOT NULL,
		 CONSTRAINT [PK_CouponAttributesReference] PRIMARY KEY CLUSTERED 
		(
			[AttributeID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [Coupon].[CouponAttributesReference] ADD  CONSTRAINT [DF_CouponAttributesReference_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [Coupon].[CouponAttributesReference] ADD  CONSTRAINT [DF_CouponAttributesReference_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[Coupon].[CouponAttributesReference]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponAttributesReference] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponAttributesReference] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CouponAttributesReference] already exists.'
	END
GO
