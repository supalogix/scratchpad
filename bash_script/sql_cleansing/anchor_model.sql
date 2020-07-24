-- DATABASE INITIALIZATION -----------------------------------------------------
--
-- The following code performs the initial setup of the PostgreSQL database with
-- required objects for the anchor database.
--
--------------------------------------------------------------------------------
-- create schema
CREATE SCHEMA IF NOT EXISTS dbo;
-- set schema search path
SET search_path = dbo;
-- drop universal function that generates checksum values
DROP FUNCTION IF EXISTS dbo.generateChecksum(text);
-- create universal function that generates checksum values
CREATE OR REPLACE FUNCTION dbo.generateChecksum(
    value text
) RETURNS bytea AS '
    BEGIN
        return cast(
            substring(
                MD5(value) for 16
            ) as bytea
        );
    END;
' LANGUAGE plpgsql;
-- KNOTS --------------------------------------------------------------------------------------------------------------
--
-- Knots are used to store finite sets of values, normally used to describe states
-- of entities (through knotted attributes) or relationships (through knotted ties).
-- Knots have their own surrogate identities and are therefore immutable.
-- Values can be added to the set over time though.
-- Knots should have values that are mutually exclusive and exhaustive.
-- Knots are unfolded when using equivalence.
--
-- KNOT TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers enable calculation and storing checksum values.
--
-- ANCHORS AND ATTRIBUTES ---------------------------------------------------------------------------------------------
--
-- Anchors are used to store the identities of entities.
-- Anchors are immutable.
-- Attributes are used to store values for properties of entities.
-- Attributes are mutable, their values may change over one or more types of time.
-- Attributes have four flavors: static, historized, knotted static, and knotted historized.
-- Anchors may have zero or more adjoined attributes.
--
-- Anchor table -------------------------------------------------------------------------------------------------------
-- AC_Account table (with 3 attributes)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_Account;
CREATE TABLE IF NOT EXISTS dbo._AC_Account (
    AC_ID serial not null, 
    AC_Dummy boolean null,
    constraint pkAC_Account primary key (
        AC_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_Account CLUSTER ON pkAC_Account;
-- DROP VIEW IF EXISTS dbo.AC_Account;
CREATE OR REPLACE VIEW dbo.AC_Account AS SELECT 
    AC_ID,
    AC_Dummy
FROM dbo._AC_Account;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- AC_IDY_Account_Identity table (on AC_Account)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_IDY_Account_Identity;
CREATE TABLE IF NOT EXISTS dbo._AC_IDY_Account_Identity (
    AC_IDY_AC_ID int not null,
    AC_IDY_Account_Identity uuid not null,
    constraint fkAC_IDY_Account_Identity foreign key (
        AC_IDY_AC_ID
    ) references dbo._AC_Account(AC_ID),
    constraint pkAC_IDY_Account_Identity primary key (
        AC_IDY_AC_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_IDY_Account_Identity CLUSTER ON pkAC_IDY_Account_Identity;
-- DROP VIEW IF EXISTS dbo.AC_IDY_Account_Identity;
CREATE OR REPLACE VIEW dbo.AC_IDY_Account_Identity AS SELECT
    AC_IDY_AC_ID,
    AC_IDY_Account_Identity
FROM dbo._AC_IDY_Account_Identity;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- AC_FNA_Account_Firstname table (on AC_Account)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_FNA_Account_Firstname;
CREATE TABLE IF NOT EXISTS dbo._AC_FNA_Account_Firstname (
    AC_FNA_AC_ID int not null,
    AC_FNA_Account_Firstname text not null,
    AC_FNA_ChangedAt timestamp not null,
    constraint fkAC_FNA_Account_Firstname foreign key (
        AC_FNA_AC_ID
    ) references dbo._AC_Account(AC_ID),
    constraint pkAC_FNA_Account_Firstname primary key (
        AC_FNA_AC_ID,
        AC_FNA_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_FNA_Account_Firstname CLUSTER ON pkAC_FNA_Account_Firstname;
-- DROP VIEW IF EXISTS dbo.AC_FNA_Account_Firstname;
CREATE OR REPLACE VIEW dbo.AC_FNA_Account_Firstname AS SELECT
    AC_FNA_AC_ID,
    AC_FNA_Account_Firstname,
    AC_FNA_ChangedAt
FROM dbo._AC_FNA_Account_Firstname;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- AC_LNA_Account_Lastname table (on AC_Account)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_LNA_Account_Lastname;
CREATE TABLE IF NOT EXISTS dbo._AC_LNA_Account_Lastname (
    AC_LNA_AC_ID int not null,
    AC_LNA_Account_Lastname text not null,
    AC_LNA_ChangedAt timestamp not null,
    constraint fkAC_LNA_Account_Lastname foreign key (
        AC_LNA_AC_ID
    ) references dbo._AC_Account(AC_ID),
    constraint pkAC_LNA_Account_Lastname primary key (
        AC_LNA_AC_ID,
        AC_LNA_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_LNA_Account_Lastname CLUSTER ON pkAC_LNA_Account_Lastname;
-- DROP VIEW IF EXISTS dbo.AC_LNA_Account_Lastname;
CREATE OR REPLACE VIEW dbo.AC_LNA_Account_Lastname AS SELECT
    AC_LNA_AC_ID,
    AC_LNA_Account_Lastname,
    AC_LNA_ChangedAt
FROM dbo._AC_LNA_Account_Lastname;
-- Anchor table -------------------------------------------------------------------------------------------------------
-- RO_Role table (with 2 attributes)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._RO_Role;
CREATE TABLE IF NOT EXISTS dbo._RO_Role (
    RO_ID serial not null, 
    RO_Dummy boolean null,
    constraint pkRO_Role primary key (
        RO_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._RO_Role CLUSTER ON pkRO_Role;
-- DROP VIEW IF EXISTS dbo.RO_Role;
CREATE OR REPLACE VIEW dbo.RO_Role AS SELECT 
    RO_ID,
    RO_Dummy
FROM dbo._RO_Role;
-- Static attribute table ---------------------------------------------------------------------------------------------
-- RO_IDY_Role_Identity table (on RO_Role)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._RO_IDY_Role_Identity;
CREATE TABLE IF NOT EXISTS dbo._RO_IDY_Role_Identity (
    RO_IDY_RO_ID int not null,
    RO_IDY_Role_Identity uuid not null,
    constraint fkRO_IDY_Role_Identity foreign key (
        RO_IDY_RO_ID
    ) references dbo._RO_Role(RO_ID),
    constraint pkRO_IDY_Role_Identity primary key (
        RO_IDY_RO_ID
    )
);
ALTER TABLE IF EXISTS ONLY dbo._RO_IDY_Role_Identity CLUSTER ON pkRO_IDY_Role_Identity;
-- DROP VIEW IF EXISTS dbo.RO_IDY_Role_Identity;
CREATE OR REPLACE VIEW dbo.RO_IDY_Role_Identity AS SELECT
    RO_IDY_RO_ID,
    RO_IDY_Role_Identity
FROM dbo._RO_IDY_Role_Identity;
-- Historized attribute table -----------------------------------------------------------------------------------------
-- RO_NAM_Role_Name table (on RO_Role)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._RO_NAM_Role_Name;
CREATE TABLE IF NOT EXISTS dbo._RO_NAM_Role_Name (
    RO_NAM_RO_ID int not null,
    RO_NAM_Role_Name text not null,
    RO_NAM_ChangedAt timestamp not null,
    constraint fkRO_NAM_Role_Name foreign key (
        RO_NAM_RO_ID
    ) references dbo._RO_Role(RO_ID),
    constraint pkRO_NAM_Role_Name primary key (
        RO_NAM_RO_ID,
        RO_NAM_ChangedAt
    )
);
ALTER TABLE IF EXISTS ONLY dbo._RO_NAM_Role_Name CLUSTER ON pkRO_NAM_Role_Name;
-- DROP VIEW IF EXISTS dbo.RO_NAM_Role_Name;
CREATE OR REPLACE VIEW dbo.RO_NAM_Role_Name AS SELECT
    RO_NAM_RO_ID,
    RO_NAM_Role_Name,
    RO_NAM_ChangedAt
FROM dbo._RO_NAM_Role_Name;
-- TIES ---------------------------------------------------------------------------------------------------------------
--
-- Ties are used to represent relationships between entities.
-- They come in four flavors: static, historized, knotted static, and knotted historized.
-- Ties have cardinality, constraining how members may participate in the relationship.
-- Every entity that is a member in a tie has a specified role in the relationship.
-- Ties must have at least two anchor roles and zero or more knot roles.
--
-- Static tie table ---------------------------------------------------------------------------------------------------
-- AC_belongsTo_RO_has table (having 2 roles)
-----------------------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS dbo._AC_belongsTo_RO_has;
CREATE TABLE IF NOT EXISTS dbo._AC_belongsTo_RO_has (
    AC_ID_belongsTo int not null, 
    RO_ID_has int not null, 
    constraint AC_belongsTo_RO_has_fkAC_belongsTo foreign key (
        AC_ID_belongsTo
    ) references dbo._AC_Account(AC_ID), 
    constraint AC_belongsTo_RO_has_fkRO_has foreign key (
        RO_ID_has
    ) references dbo._RO_Role(RO_ID), 
    constraint pkAC_belongsTo_RO_has primary key (
        AC_ID_belongsTo,
        RO_ID_has
    )
);
ALTER TABLE IF EXISTS ONLY dbo._AC_belongsTo_RO_has CLUSTER ON pkAC_belongsTo_RO_has;
-- DROP VIEW IF EXISTS dbo.AC_belongsTo_RO_has;
CREATE OR REPLACE VIEW dbo.AC_belongsTo_RO_has AS SELECT
    AC_ID_belongsTo,
    RO_ID_has
FROM dbo._AC_belongsTo_RO_has;
-- ATTRIBUTE RESTATEMENT CONSTRAINTS ----------------------------------------------------------------------------------
--
-- Attributes may be prevented from storing restatements.
-- A restatement is when the same value occurs for two adjacent points
-- in changing time.
--
-- returns 1 for at least one equal surrounding value, 0 for different surrounding values
--
-- id the identity of the anchored entity
-- eq the equivalent (when applicable)
-- value the value of the attribute
-- changed the point in time from which this value shall represent a change
--
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfAC_FNA_Account_Firstname restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcAC_FNA_Account_Firstname restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfAC_FNA_Account_Firstname(
    int,
    text,
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfAC_FNA_Account_Firstname(
    id int,
    value text,
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.AC_FNA_Account_Firstname
                    FROM
                        dbo.AC_FNA_Account_Firstname pre
                    WHERE
                        pre.AC_FNA_AC_ID = id
                    AND
                        pre.AC_FNA_ChangedAt < changed
                    ORDER BY
                        pre.AC_FNA_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.AC_FNA_Account_Firstname
                    FROM
                        dbo.AC_FNA_Account_Firstname fol
                    WHERE
                        fol.AC_FNA_AC_ID = id
                    AND
                        fol.AC_FNA_ChangedAt > changed
                    ORDER BY
                        fol.AC_FNA_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfAC_LNA_Account_Lastname restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcAC_LNA_Account_Lastname restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfAC_LNA_Account_Lastname(
    int,
    text,
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfAC_LNA_Account_Lastname(
    id int,
    value text,
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.AC_LNA_Account_Lastname
                    FROM
                        dbo.AC_LNA_Account_Lastname pre
                    WHERE
                        pre.AC_LNA_AC_ID = id
                    AND
                        pre.AC_LNA_ChangedAt < changed
                    ORDER BY
                        pre.AC_LNA_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.AC_LNA_Account_Lastname
                    FROM
                        dbo.AC_LNA_Account_Lastname fol
                    WHERE
                        fol.AC_LNA_AC_ID = id
                    AND
                        fol.AC_LNA_ChangedAt > changed
                    ORDER BY
                        fol.AC_LNA_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- Restatement Finder Function and Constraint -------------------------------------------------------------------------
-- rfRO_NAM_Role_Name restatement finder, also used by the insert and update triggers for idempotent attributes
-- rcRO_NAM_Role_Name restatement constraint (available only in attributes that cannot have restatements)
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rfRO_NAM_Role_Name(
    int,
    text,
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rfRO_NAM_Role_Name(
    id int,
    value text,
    changed timestamp
) RETURNS smallint AS '
    BEGIN
        IF EXISTS (
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        pre.RO_NAM_Role_Name
                    FROM
                        dbo.RO_NAM_Role_Name pre
                    WHERE
                        pre.RO_NAM_RO_ID = id
                    AND
                        pre.RO_NAM_ChangedAt < changed
                    ORDER BY
                        pre.RO_NAM_ChangedAt DESC
                    LIMIT 1
            )
        )
        OR EXISTS(
            SELECT
                value 
            WHERE
                value = (
                    SELECT
                        fol.RO_NAM_Role_Name
                    FROM
                        dbo.RO_NAM_Role_Name fol
                    WHERE
                        fol.RO_NAM_RO_ID = id
                    AND
                        fol.RO_NAM_ChangedAt > changed
                    ORDER BY
                        fol.RO_NAM_ChangedAt ASC
                    LIMIT 1
            )
        )
        THEN
            RETURN 1;
        END IF;
        RETURN 0;
    END;
' LANGUAGE plpgsql;
-- KEY GENERATORS -----------------------------------------------------------------------------------------------------
--
-- These stored procedures can be used to generate identities of entities.
-- Corresponding anchors must have an incrementing identity column.
--
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kAC_Account identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
--DROP FUNCTION IF EXISTS dbo.kAC_Account(
-- bigint
--);
CREATE OR REPLACE FUNCTION dbo.kAC_Account(
    requestedNumberOfIdentities bigint
) RETURNS void AS '
    BEGIN
        IF requestedNumberOfIdentities > 0
        THEN
            WITH RECURSIVE idGenerator (idNumber) AS (
                SELECT
                    1
                UNION ALL
                SELECT
                    idNumber + 1
                FROM
                    idGenerator
                WHERE
                    idNumber < requestedNumberOfIdentities
            )
            INSERT INTO dbo.AC_Account (
                AC_Dummy
            )
            SELECT
                null
            FROM
                idGenerator;
        END IF;
    END;
' LANGUAGE plpgsql;
-- Key Generation Stored Procedure ------------------------------------------------------------------------------------
-- kRO_Role identity by surrogate key generation stored procedure
-----------------------------------------------------------------------------------------------------------------------
--DROP FUNCTION IF EXISTS dbo.kRO_Role(
-- bigint
--);
CREATE OR REPLACE FUNCTION dbo.kRO_Role(
    requestedNumberOfIdentities bigint
) RETURNS void AS '
    BEGIN
        IF requestedNumberOfIdentities > 0
        THEN
            WITH RECURSIVE idGenerator (idNumber) AS (
                SELECT
                    1
                UNION ALL
                SELECT
                    idNumber + 1
                FROM
                    idGenerator
                WHERE
                    idNumber < requestedNumberOfIdentities
            )
            INSERT INTO dbo.RO_Role (
                RO_Dummy
            )
            SELECT
                null
            FROM
                idGenerator;
        END IF;
    END;
' LANGUAGE plpgsql;
-- ATTRIBUTE REWINDERS ------------------------------------------------------------------------------------------------
--
-- These table valued functions rewind an attribute table to the given
-- point in changing time. It does not pick a temporal perspective and
-- instead shows all rows that have been in effect before that point
-- in time.
--
-- changingTimepoint the point in changing time to rewind to
--
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rAC_FNA_Account_Firstname rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rAC_FNA_Account_Firstname(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rAC_FNA_Account_Firstname(
    changingTimepoint timestamp
) RETURNS TABLE(
    AC_FNA_AC_ID int,
    AC_FNA_Account_Firstname text,
    AC_FNA_ChangedAt timestamp
) AS '
    SELECT
        AC_FNA_AC_ID,
        AC_FNA_Account_Firstname,
        AC_FNA_ChangedAt
    FROM
        dbo.AC_FNA_Account_Firstname
    WHERE
        AC_FNA_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rAC_LNA_Account_Lastname rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rAC_LNA_Account_Lastname(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rAC_LNA_Account_Lastname(
    changingTimepoint timestamp
) RETURNS TABLE(
    AC_LNA_AC_ID int,
    AC_LNA_Account_Lastname text,
    AC_LNA_ChangedAt timestamp
) AS '
    SELECT
        AC_LNA_AC_ID,
        AC_LNA_Account_Lastname,
        AC_LNA_ChangedAt
    FROM
        dbo.AC_LNA_Account_Lastname
    WHERE
        AC_LNA_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- Attribute rewinder -------------------------------------------------------------------------------------------------
-- rRO_NAM_Role_Name rewinding over changing time function
-----------------------------------------------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.rRO_NAM_Role_Name(
    timestamp
);
*/
CREATE OR REPLACE FUNCTION dbo.rRO_NAM_Role_Name(
    changingTimepoint timestamp
) RETURNS TABLE(
    RO_NAM_RO_ID int,
    RO_NAM_Role_Name text,
    RO_NAM_ChangedAt timestamp
) AS '
    SELECT
        RO_NAM_RO_ID,
        RO_NAM_Role_Name,
        RO_NAM_ChangedAt
    FROM
        dbo.RO_NAM_Role_Name
    WHERE
        RO_NAM_ChangedAt <= changingTimepoint;
' LANGUAGE SQL;
-- ANCHOR TEMPORAL PERSPECTIVES ---------------------------------------------------------------------------------------
--
-- These functions simplify temporal querying by providing a temporal
-- perspective of each anchor. There are four types of perspectives: latest,
-- point-in-time, difference, and now. They also denormalize the anchor, its attributes,
-- and referenced knots from sixth to third normal form.
--
-- The latest perspective shows the latest available information for each anchor.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints, and for
-- changes in all or a selection of attributes.
--
-- intervalStart the start of the interval for finding changes
-- intervalEnd the end of the interval for finding changes
-- selection a list of mnemonics for tracked attributes, ie 'MNE MON ICS', or null for all
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- equivalent the equivalent for which to retrieve data
--
-- DROP ANCHOR TEMPORAL PERSPECTIVES ----------------------------------------------------------------------------------
/*
DROP FUNCTION IF EXISTS dbo.dAC_Account(
    timestamp without time zone, 
    timestamp without time zone, 
    text
);
DROP VIEW IF EXISTS dbo.nAC_Account;
DROP FUNCTION IF EXISTS dbo.pAC_Account(
    timestamp without time zone
);
DROP VIEW IF EXISTS dbo.lAC_Account;
DROP FUNCTION IF EXISTS dbo.dRO_Role(
    timestamp without time zone, 
    timestamp without time zone, 
    text
);
DROP VIEW IF EXISTS dbo.nRO_Role;
DROP FUNCTION IF EXISTS dbo.pRO_Role(
    timestamp without time zone
);
DROP VIEW IF EXISTS dbo.lRO_Role;
*/
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lAC_Account viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lAC_Account AS
SELECT
    AC.AC_ID,
    IDY.AC_IDY_AC_ID,
    IDY.AC_IDY_Account_Identity,
    FNA.AC_FNA_AC_ID,
    FNA.AC_FNA_ChangedAt,
    FNA.AC_FNA_Account_Firstname,
    LNA.AC_LNA_AC_ID,
    LNA.AC_LNA_ChangedAt,
    LNA.AC_LNA_Account_Lastname
FROM
    dbo.AC_Account AC
LEFT JOIN
    dbo.AC_IDY_Account_Identity IDY
ON
    IDY.AC_IDY_AC_ID = AC.AC_ID
LEFT JOIN
    dbo.AC_FNA_Account_Firstname FNA
ON
    FNA.AC_FNA_AC_ID = AC.AC_ID
AND
    FNA.AC_FNA_ChangedAt = (
        SELECT
            max(sub.AC_FNA_ChangedAt)
        FROM
            dbo.AC_FNA_Account_Firstname sub
        WHERE
            sub.AC_FNA_AC_ID = AC.AC_ID
   )
LEFT JOIN
    dbo.AC_LNA_Account_Lastname LNA
ON
    LNA.AC_LNA_AC_ID = AC.AC_ID
AND
    LNA.AC_LNA_ChangedAt = (
        SELECT
            max(sub.AC_LNA_ChangedAt)
        FROM
            dbo.AC_LNA_Account_Lastname sub
        WHERE
            sub.AC_LNA_AC_ID = AC.AC_ID
   );
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lRO_Role viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lRO_Role AS
SELECT
    RO.RO_ID,
    IDY.RO_IDY_RO_ID,
    IDY.RO_IDY_Role_Identity,
    NAM.RO_NAM_RO_ID,
    NAM.RO_NAM_ChangedAt,
    NAM.RO_NAM_Role_Name
FROM
    dbo.RO_Role RO
LEFT JOIN
    dbo.RO_IDY_Role_Identity IDY
ON
    IDY.RO_IDY_RO_ID = RO.RO_ID
LEFT JOIN
    dbo.RO_NAM_Role_Name NAM
ON
    NAM.RO_NAM_RO_ID = RO.RO_ID
AND
    NAM.RO_NAM_ChangedAt = (
        SELECT
            max(sub.RO_NAM_ChangedAt)
        FROM
            dbo.RO_NAM_Role_Name sub
        WHERE
            sub.RO_NAM_RO_ID = RO.RO_ID
   );
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pAC_Account viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pAC_Account (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    AC_ID int,
    AC_IDY_AC_ID int,
    AC_IDY_Account_Identity uuid,
    AC_FNA_AC_ID int,
    AC_FNA_ChangedAt timestamp,
    AC_FNA_Account_Firstname text,
    AC_LNA_AC_ID int,
    AC_LNA_ChangedAt timestamp,
    AC_LNA_Account_Lastname text
) AS '
SELECT
    AC.AC_ID,
    IDY.AC_IDY_AC_ID,
    IDY.AC_IDY_Account_Identity,
    FNA.AC_FNA_AC_ID,
    FNA.AC_FNA_ChangedAt,
    FNA.AC_FNA_Account_Firstname,
    LNA.AC_LNA_AC_ID,
    LNA.AC_LNA_ChangedAt,
    LNA.AC_LNA_Account_Lastname
FROM
    dbo.AC_Account AC
LEFT JOIN
    dbo.AC_IDY_Account_Identity IDY
ON
    IDY.AC_IDY_AC_ID = AC.AC_ID
LEFT JOIN
    dbo.rAC_FNA_Account_Firstname(CAST(changingTimepoint AS timestamp)) FNA
ON
    FNA.AC_FNA_AC_ID = AC.AC_ID
AND
    FNA.AC_FNA_ChangedAt = (
        SELECT
            max(sub.AC_FNA_ChangedAt)
        FROM
            dbo.rAC_FNA_Account_Firstname(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.AC_FNA_AC_ID = AC.AC_ID
   )
LEFT JOIN
    dbo.rAC_LNA_Account_Lastname(CAST(changingTimepoint AS timestamp)) LNA
ON
    LNA.AC_LNA_AC_ID = AC.AC_ID
AND
    LNA.AC_LNA_ChangedAt = (
        SELECT
            max(sub.AC_LNA_ChangedAt)
        FROM
            dbo.rAC_LNA_Account_Lastname(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.AC_LNA_AC_ID = AC.AC_ID
   );
' LANGUAGE SQL;
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pRO_Role viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pRO_Role (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    RO_ID int,
    RO_IDY_RO_ID int,
    RO_IDY_Role_Identity uuid,
    RO_NAM_RO_ID int,
    RO_NAM_ChangedAt timestamp,
    RO_NAM_Role_Name text
) AS '
SELECT
    RO.RO_ID,
    IDY.RO_IDY_RO_ID,
    IDY.RO_IDY_Role_Identity,
    NAM.RO_NAM_RO_ID,
    NAM.RO_NAM_ChangedAt,
    NAM.RO_NAM_Role_Name
FROM
    dbo.RO_Role RO
LEFT JOIN
    dbo.RO_IDY_Role_Identity IDY
ON
    IDY.RO_IDY_RO_ID = RO.RO_ID
LEFT JOIN
    dbo.rRO_NAM_Role_Name(CAST(changingTimepoint AS timestamp)) NAM
ON
    NAM.RO_NAM_RO_ID = RO.RO_ID
AND
    NAM.RO_NAM_ChangedAt = (
        SELECT
            max(sub.RO_NAM_ChangedAt)
        FROM
            dbo.rRO_NAM_Role_Name(CAST(changingTimepoint AS timestamp)) sub
        WHERE
            sub.RO_NAM_RO_ID = RO.RO_ID
   );
' LANGUAGE SQL;
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nAC_Account viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nAC_Account AS
SELECT
    *
FROM
    dbo.pAC_Account(LOCALTIMESTAMP);
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nRO_Role viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nRO_Role AS
SELECT
    *
FROM
    dbo.pRO_Role(LOCALTIMESTAMP);
-- Difference perspective ---------------------------------------------------------------------------------------------
-- dAC_Account showing all differences between the given timepoints and optionally for a subset of attributes
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.dAC_Account (
    intervalStart timestamp without time zone,
    intervalEnd timestamp without time zone,
    selection text = null
) RETURNS TABLE (
    inspectedTimepoint timestamp without time zone,
    mnemonic text,
    AC_ID int,
    AC_IDY_AC_ID int,
    AC_IDY_Account_Identity uuid,
    AC_FNA_AC_ID int,
    AC_FNA_ChangedAt timestamp,
    AC_FNA_Account_Firstname text,
    AC_LNA_AC_ID int,
    AC_LNA_ChangedAt timestamp,
    AC_LNA_Account_Lastname text
) AS '
SELECT
    timepoints.inspectedTimepoint,
    timepoints.mnemonic,
    pAC.*
FROM (
    SELECT DISTINCT
        AC_FNA_AC_ID AS AC_ID,
        CAST(AC_FNA_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''FNA'' AS mnemonic
    FROM
        dbo.AC_FNA_Account_Firstname
    WHERE
        (selection is null OR selection like ''%FNA%'')
    AND
        AC_FNA_ChangedAt BETWEEN intervalStart AND intervalEnd
    UNION
    SELECT DISTINCT
        AC_LNA_AC_ID AS AC_ID,
        CAST(AC_LNA_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''LNA'' AS mnemonic
    FROM
        dbo.AC_LNA_Account_Lastname
    WHERE
        (selection is null OR selection like ''%LNA%'')
    AND
        AC_LNA_ChangedAt BETWEEN intervalStart AND intervalEnd
) timepoints
CROSS JOIN LATERAL
    dbo.pAC_Account(timepoints.inspectedTimepoint) pAC
WHERE
    pAC.AC_ID = timepoints.AC_ID;
' LANGUAGE SQL;
-- Difference perspective ---------------------------------------------------------------------------------------------
-- dRO_Role showing all differences between the given timepoints and optionally for a subset of attributes
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.dRO_Role (
    intervalStart timestamp without time zone,
    intervalEnd timestamp without time zone,
    selection text = null
) RETURNS TABLE (
    inspectedTimepoint timestamp without time zone,
    mnemonic text,
    RO_ID int,
    RO_IDY_RO_ID int,
    RO_IDY_Role_Identity uuid,
    RO_NAM_RO_ID int,
    RO_NAM_ChangedAt timestamp,
    RO_NAM_Role_Name text
) AS '
SELECT
    timepoints.inspectedTimepoint,
    timepoints.mnemonic,
    pRO.*
FROM (
    SELECT DISTINCT
        RO_NAM_RO_ID AS RO_ID,
        CAST(RO_NAM_ChangedAt AS timestamp without time zone) AS inspectedTimepoint,
        ''NAM'' AS mnemonic
    FROM
        dbo.RO_NAM_Role_Name
    WHERE
        (selection is null OR selection like ''%NAM%'')
    AND
        RO_NAM_ChangedAt BETWEEN intervalStart AND intervalEnd
) timepoints
CROSS JOIN LATERAL
    dbo.pRO_Role(timepoints.inspectedTimepoint) pRO
WHERE
    pRO.RO_ID = timepoints.RO_ID;
' LANGUAGE SQL;
-- ATTRIBUTE TRIGGERS -------------------------------------------------------------------------------------------------
--
-- The following triggers on the attributes make them behave like tables.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbAC_IDY_Account_Identity ON dbo.AC_IDY_Account_Identity;
DROP FUNCTION IF EXISTS dbo.tcbAC_IDY_Account_Identity();
CREATE OR REPLACE FUNCTION dbo.tcbAC_IDY_Account_Identity() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_AC_IDY_Account_Identity (
            AC_IDY_AC_ID int not null,
            AC_IDY_Account_Identity uuid not null,
            AC_IDY_Version bigint not null,
            AC_IDY_StatementType char(1) not null,
            primary key(
                AC_IDY_Version,
                AC_IDY_AC_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbAC_IDY_Account_Identity
BEFORE INSERT ON dbo.AC_IDY_Account_Identity
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbAC_IDY_Account_Identity();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciAC_IDY_Account_Identity ON dbo.AC_IDY_Account_Identity;
DROP FUNCTION IF EXISTS dbo.tciAC_IDY_Account_Identity();
CREATE OR REPLACE FUNCTION dbo.tciAC_IDY_Account_Identity() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_AC_IDY_Account_Identity
        SELECT
            NEW.AC_IDY_AC_ID,
            NEW.AC_IDY_Account_Identity,
            1,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciAC_IDY_Account_Identity
INSTEAD OF INSERT ON dbo.AC_IDY_Account_Identity
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciAC_IDY_Account_Identity();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaAC_IDY_Account_Identity ON dbo.AC_IDY_Account_Identity;
DROP FUNCTION IF EXISTS dbo.tcaAC_IDY_Account_Identity();
CREATE OR REPLACE FUNCTION dbo.tcaAC_IDY_Account_Identity() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find max version
    SELECT
        MAX(AC_IDY_Version) INTO maxVersion
    FROM
        _tmp_AC_IDY_Account_Identity;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_AC_IDY_Account_Identity
        SET
            AC_IDY_StatementType =
                CASE
                    WHEN IDY.AC_IDY_AC_ID is not null
                    THEN ''D'' -- duplicate
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_AC_IDY_Account_Identity v
        LEFT JOIN
            dbo._AC_IDY_Account_Identity IDY
        ON
            IDY.AC_IDY_AC_ID = v.AC_IDY_AC_ID
        AND
            IDY.AC_IDY_Account_Identity = v.AC_IDY_Account_Identity
        WHERE
            v.AC_IDY_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._AC_IDY_Account_Identity (
            AC_IDY_AC_ID,
            AC_IDY_Account_Identity
        )
        SELECT
            AC_IDY_AC_ID,
            AC_IDY_Account_Identity
        FROM
            _tmp_AC_IDY_Account_Identity
        WHERE
            AC_IDY_Version = currentVersion
        AND
            AC_IDY_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_AC_IDY_Account_Identity;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaAC_IDY_Account_Identity
AFTER INSERT ON dbo.AC_IDY_Account_Identity
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaAC_IDY_Account_Identity();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbAC_FNA_Account_Firstname ON dbo.AC_FNA_Account_Firstname;
DROP FUNCTION IF EXISTS dbo.tcbAC_FNA_Account_Firstname();
CREATE OR REPLACE FUNCTION dbo.tcbAC_FNA_Account_Firstname() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_AC_FNA_Account_Firstname (
            AC_FNA_AC_ID int not null,
            AC_FNA_ChangedAt timestamp not null,
            AC_FNA_Account_Firstname text not null,
            AC_FNA_Version bigint not null,
            AC_FNA_StatementType char(1) not null,
            primary key(
                AC_FNA_Version,
                AC_FNA_AC_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbAC_FNA_Account_Firstname
BEFORE INSERT ON dbo.AC_FNA_Account_Firstname
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbAC_FNA_Account_Firstname();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciAC_FNA_Account_Firstname ON dbo.AC_FNA_Account_Firstname;
DROP FUNCTION IF EXISTS dbo.tciAC_FNA_Account_Firstname();
CREATE OR REPLACE FUNCTION dbo.tciAC_FNA_Account_Firstname() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_AC_FNA_Account_Firstname
        SELECT
            NEW.AC_FNA_AC_ID,
            NEW.AC_FNA_ChangedAt,
            NEW.AC_FNA_Account_Firstname,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciAC_FNA_Account_Firstname
INSTEAD OF INSERT ON dbo.AC_FNA_Account_Firstname
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciAC_FNA_Account_Firstname();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaAC_FNA_Account_Firstname ON dbo.AC_FNA_Account_Firstname;
DROP FUNCTION IF EXISTS dbo.tcaAC_FNA_Account_Firstname();
CREATE OR REPLACE FUNCTION dbo.tcaAC_FNA_Account_Firstname() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_AC_FNA_Account_Firstname
    SET AC_FNA_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    AC_FNA_AC_ID
                ORDER BY
                    AC_FNA_ChangedAt ASC
            ) AS rank,
            AC_FNA_AC_ID AS pk
        FROM _tmp_AC_FNA_Account_Firstname
    ) AS v
    WHERE AC_FNA_AC_ID = v.pk
    AND AC_FNA_Version = 0;
    -- find max version
    SELECT
        MAX(AC_FNA_Version) INTO maxVersion
    FROM
        _tmp_AC_FNA_Account_Firstname;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_AC_FNA_Account_Firstname
        SET
            AC_FNA_StatementType =
                CASE
                    WHEN FNA.AC_FNA_AC_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfAC_FNA_Account_Firstname(
                        v.AC_FNA_AC_ID,
                        v.AC_FNA_Account_Firstname,
                        v.AC_FNA_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_AC_FNA_Account_Firstname v
        LEFT JOIN
            dbo._AC_FNA_Account_Firstname FNA
        ON
            FNA.AC_FNA_AC_ID = v.AC_FNA_AC_ID
        AND
            FNA.AC_FNA_ChangedAt = v.AC_FNA_ChangedAt
        AND
            FNA.AC_FNA_Account_Firstname = v.AC_FNA_Account_Firstname
        WHERE
            v.AC_FNA_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._AC_FNA_Account_Firstname (
            AC_FNA_AC_ID,
            AC_FNA_ChangedAt,
            AC_FNA_Account_Firstname
        )
        SELECT
            AC_FNA_AC_ID,
            AC_FNA_ChangedAt,
            AC_FNA_Account_Firstname
        FROM
            _tmp_AC_FNA_Account_Firstname
        WHERE
            AC_FNA_Version = currentVersion
        AND
            AC_FNA_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_AC_FNA_Account_Firstname;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaAC_FNA_Account_Firstname
AFTER INSERT ON dbo.AC_FNA_Account_Firstname
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaAC_FNA_Account_Firstname();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbAC_LNA_Account_Lastname ON dbo.AC_LNA_Account_Lastname;
DROP FUNCTION IF EXISTS dbo.tcbAC_LNA_Account_Lastname();
CREATE OR REPLACE FUNCTION dbo.tcbAC_LNA_Account_Lastname() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_AC_LNA_Account_Lastname (
            AC_LNA_AC_ID int not null,
            AC_LNA_ChangedAt timestamp not null,
            AC_LNA_Account_Lastname text not null,
            AC_LNA_Version bigint not null,
            AC_LNA_StatementType char(1) not null,
            primary key(
                AC_LNA_Version,
                AC_LNA_AC_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbAC_LNA_Account_Lastname
BEFORE INSERT ON dbo.AC_LNA_Account_Lastname
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbAC_LNA_Account_Lastname();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciAC_LNA_Account_Lastname ON dbo.AC_LNA_Account_Lastname;
DROP FUNCTION IF EXISTS dbo.tciAC_LNA_Account_Lastname();
CREATE OR REPLACE FUNCTION dbo.tciAC_LNA_Account_Lastname() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_AC_LNA_Account_Lastname
        SELECT
            NEW.AC_LNA_AC_ID,
            NEW.AC_LNA_ChangedAt,
            NEW.AC_LNA_Account_Lastname,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciAC_LNA_Account_Lastname
INSTEAD OF INSERT ON dbo.AC_LNA_Account_Lastname
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciAC_LNA_Account_Lastname();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaAC_LNA_Account_Lastname ON dbo.AC_LNA_Account_Lastname;
DROP FUNCTION IF EXISTS dbo.tcaAC_LNA_Account_Lastname();
CREATE OR REPLACE FUNCTION dbo.tcaAC_LNA_Account_Lastname() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_AC_LNA_Account_Lastname
    SET AC_LNA_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    AC_LNA_AC_ID
                ORDER BY
                    AC_LNA_ChangedAt ASC
            ) AS rank,
            AC_LNA_AC_ID AS pk
        FROM _tmp_AC_LNA_Account_Lastname
    ) AS v
    WHERE AC_LNA_AC_ID = v.pk
    AND AC_LNA_Version = 0;
    -- find max version
    SELECT
        MAX(AC_LNA_Version) INTO maxVersion
    FROM
        _tmp_AC_LNA_Account_Lastname;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_AC_LNA_Account_Lastname
        SET
            AC_LNA_StatementType =
                CASE
                    WHEN LNA.AC_LNA_AC_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfAC_LNA_Account_Lastname(
                        v.AC_LNA_AC_ID,
                        v.AC_LNA_Account_Lastname,
                        v.AC_LNA_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_AC_LNA_Account_Lastname v
        LEFT JOIN
            dbo._AC_LNA_Account_Lastname LNA
        ON
            LNA.AC_LNA_AC_ID = v.AC_LNA_AC_ID
        AND
            LNA.AC_LNA_ChangedAt = v.AC_LNA_ChangedAt
        AND
            LNA.AC_LNA_Account_Lastname = v.AC_LNA_Account_Lastname
        WHERE
            v.AC_LNA_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._AC_LNA_Account_Lastname (
            AC_LNA_AC_ID,
            AC_LNA_ChangedAt,
            AC_LNA_Account_Lastname
        )
        SELECT
            AC_LNA_AC_ID,
            AC_LNA_ChangedAt,
            AC_LNA_Account_Lastname
        FROM
            _tmp_AC_LNA_Account_Lastname
        WHERE
            AC_LNA_Version = currentVersion
        AND
            AC_LNA_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_AC_LNA_Account_Lastname;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaAC_LNA_Account_Lastname
AFTER INSERT ON dbo.AC_LNA_Account_Lastname
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaAC_LNA_Account_Lastname();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbRO_IDY_Role_Identity ON dbo.RO_IDY_Role_Identity;
DROP FUNCTION IF EXISTS dbo.tcbRO_IDY_Role_Identity();
CREATE OR REPLACE FUNCTION dbo.tcbRO_IDY_Role_Identity() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_RO_IDY_Role_Identity (
            RO_IDY_RO_ID int not null,
            RO_IDY_Role_Identity uuid not null,
            RO_IDY_Version bigint not null,
            RO_IDY_StatementType char(1) not null,
            primary key(
                RO_IDY_Version,
                RO_IDY_RO_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbRO_IDY_Role_Identity
BEFORE INSERT ON dbo.RO_IDY_Role_Identity
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbRO_IDY_Role_Identity();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciRO_IDY_Role_Identity ON dbo.RO_IDY_Role_Identity;
DROP FUNCTION IF EXISTS dbo.tciRO_IDY_Role_Identity();
CREATE OR REPLACE FUNCTION dbo.tciRO_IDY_Role_Identity() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_RO_IDY_Role_Identity
        SELECT
            NEW.RO_IDY_RO_ID,
            NEW.RO_IDY_Role_Identity,
            1,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciRO_IDY_Role_Identity
INSTEAD OF INSERT ON dbo.RO_IDY_Role_Identity
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciRO_IDY_Role_Identity();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaRO_IDY_Role_Identity ON dbo.RO_IDY_Role_Identity;
DROP FUNCTION IF EXISTS dbo.tcaRO_IDY_Role_Identity();
CREATE OR REPLACE FUNCTION dbo.tcaRO_IDY_Role_Identity() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find max version
    SELECT
        MAX(RO_IDY_Version) INTO maxVersion
    FROM
        _tmp_RO_IDY_Role_Identity;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_RO_IDY_Role_Identity
        SET
            RO_IDY_StatementType =
                CASE
                    WHEN IDY.RO_IDY_RO_ID is not null
                    THEN ''D'' -- duplicate
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_RO_IDY_Role_Identity v
        LEFT JOIN
            dbo._RO_IDY_Role_Identity IDY
        ON
            IDY.RO_IDY_RO_ID = v.RO_IDY_RO_ID
        AND
            IDY.RO_IDY_Role_Identity = v.RO_IDY_Role_Identity
        WHERE
            v.RO_IDY_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._RO_IDY_Role_Identity (
            RO_IDY_RO_ID,
            RO_IDY_Role_Identity
        )
        SELECT
            RO_IDY_RO_ID,
            RO_IDY_Role_Identity
        FROM
            _tmp_RO_IDY_Role_Identity
        WHERE
            RO_IDY_Version = currentVersion
        AND
            RO_IDY_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_RO_IDY_Role_Identity;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaRO_IDY_Role_Identity
AFTER INSERT ON dbo.RO_IDY_Role_Identity
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaRO_IDY_Role_Identity();
-- BEFORE INSERT trigger ----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcbRO_NAM_Role_Name ON dbo.RO_NAM_Role_Name;
DROP FUNCTION IF EXISTS dbo.tcbRO_NAM_Role_Name();
CREATE OR REPLACE FUNCTION dbo.tcbRO_NAM_Role_Name() RETURNS trigger AS '
    BEGIN
        -- temporary table is used to create an insert order 
        -- (so that rows are inserted in order with respect to temporality)
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_RO_NAM_Role_Name (
            RO_NAM_RO_ID int not null,
            RO_NAM_ChangedAt timestamp not null,
            RO_NAM_Role_Name text not null,
            RO_NAM_Version bigint not null,
            RO_NAM_StatementType char(1) not null,
            primary key(
                RO_NAM_Version,
                RO_NAM_RO_ID
            )
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcbRO_NAM_Role_Name
BEFORE INSERT ON dbo.RO_NAM_Role_Name
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcbRO_NAM_Role_Name();
-- INSTEAD OF INSERT trigger ------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tciRO_NAM_Role_Name ON dbo.RO_NAM_Role_Name;
DROP FUNCTION IF EXISTS dbo.tciRO_NAM_Role_Name();
CREATE OR REPLACE FUNCTION dbo.tciRO_NAM_Role_Name() RETURNS trigger AS '
    BEGIN
        -- insert rows into the temporary table
        INSERT INTO _tmp_RO_NAM_Role_Name
        SELECT
            NEW.RO_NAM_RO_ID,
            NEW.RO_NAM_ChangedAt,
            NEW.RO_NAM_Role_Name,
            0,
            ''X'';
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER tciRO_NAM_Role_Name
INSTEAD OF INSERT ON dbo.RO_NAM_Role_Name
FOR EACH ROW
EXECUTE PROCEDURE dbo.tciRO_NAM_Role_Name();
-- AFTER INSERT trigger -----------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS tcaRO_NAM_Role_Name ON dbo.RO_NAM_Role_Name;
DROP FUNCTION IF EXISTS dbo.tcaRO_NAM_Role_Name();
CREATE OR REPLACE FUNCTION dbo.tcaRO_NAM_Role_Name() RETURNS trigger AS '
    DECLARE maxVersion int;
    DECLARE currentVersion int = 0;
BEGIN
    -- find ranks for inserted data (using self join)
    UPDATE _tmp_RO_NAM_Role_Name
    SET RO_NAM_Version = v.rank
    FROM (
        SELECT
            DENSE_RANK() OVER (
                PARTITION BY
                    RO_NAM_RO_ID
                ORDER BY
                    RO_NAM_ChangedAt ASC
            ) AS rank,
            RO_NAM_RO_ID AS pk
        FROM _tmp_RO_NAM_Role_Name
    ) AS v
    WHERE RO_NAM_RO_ID = v.pk
    AND RO_NAM_Version = 0;
    -- find max version
    SELECT
        MAX(RO_NAM_Version) INTO maxVersion
    FROM
        _tmp_RO_NAM_Role_Name;
    -- is max version NULL?
    IF (maxVersion is null) THEN
        RETURN NULL;
    END IF;
    -- loop over versions
    LOOP
        currentVersion := currentVersion + 1;
        -- set statement types
        UPDATE _tmp_RO_NAM_Role_Name
        SET
            RO_NAM_StatementType =
                CASE
                    WHEN NAM.RO_NAM_RO_ID is not null
                    THEN ''D'' -- duplicate
                    WHEN dbo.rfRO_NAM_Role_Name(
                        v.RO_NAM_RO_ID,
                        v.RO_NAM_Role_Name,
                        v.RO_NAM_ChangedAt
                    ) = 1
                    THEN ''R'' -- restatement
                    ELSE ''N'' -- new statement
                END
        FROM
            _tmp_RO_NAM_Role_Name v
        LEFT JOIN
            dbo._RO_NAM_Role_Name NAM
        ON
            NAM.RO_NAM_RO_ID = v.RO_NAM_RO_ID
        AND
            NAM.RO_NAM_ChangedAt = v.RO_NAM_ChangedAt
        AND
            NAM.RO_NAM_Role_Name = v.RO_NAM_Role_Name
        WHERE
            v.RO_NAM_Version = currentVersion;
        -- insert data into attribute table
        INSERT INTO dbo._RO_NAM_Role_Name (
            RO_NAM_RO_ID,
            RO_NAM_ChangedAt,
            RO_NAM_Role_Name
        )
        SELECT
            RO_NAM_RO_ID,
            RO_NAM_ChangedAt,
            RO_NAM_Role_Name
        FROM
            _tmp_RO_NAM_Role_Name
        WHERE
            RO_NAM_Version = currentVersion
        AND
            RO_NAM_StatementType in (''N'');
        EXIT WHEN currentVersion >= maxVersion;
    END LOOP;
    DROP TABLE IF EXISTS _tmp_RO_NAM_Role_Name;
    RETURN NULL;
END;
' LANGUAGE plpgsql;
CREATE TRIGGER tcaRO_NAM_Role_Name
AFTER INSERT ON dbo.RO_NAM_Role_Name
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.tcaRO_NAM_Role_Name();
-- ANCHOR TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
-- BEFORE INSERT trigger --------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS itb_lAC_Account ON dbo.lAC_Account;
DROP FUNCTION IF EXISTS dbo.itb_lAC_Account();
CREATE OR REPLACE FUNCTION dbo.itb_lAC_Account() RETURNS trigger AS '
    BEGIN
        -- create temporary table to keep inserted rows in
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_it_AC_Account (
            AC_ID int not null,
            AC_IDY_AC_ID int null,
            AC_IDY_Account_Identity uuid null,
            AC_FNA_AC_ID int null,
            AC_FNA_ChangedAt timestamp null,
            AC_FNA_Account_Firstname text null,
            AC_LNA_AC_ID int null,
            AC_LNA_ChangedAt timestamp null,
            AC_LNA_Account_Lastname text null
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER itb_lAC_Account
BEFORE INSERT ON dbo.lAC_Account
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.itb_lAC_Account(); 
-- INSTEAD OF INSERT trigger ----------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS iti_lAC_Account ON dbo.lAC_Account;
DROP FUNCTION IF EXISTS dbo.iti_lAC_Account();
CREATE OR REPLACE FUNCTION dbo.iti_lAC_Account() RETURNS trigger AS '
    BEGIN
        -- generate anchor ID (if not provided)
        IF (NEW.AC_ID IS NULL) THEN 
            INSERT INTO dbo.AC_Account (
                AC_Dummy
            ) VALUES (
                null
            );
            SELECT
                lastval() 
            INTO NEW.AC_ID;
        -- if anchor ID is provided then let''s insert it into the anchor table
        -- but only if that ID is not present in the anchor table
        ELSE
            INSERT INTO dbo.AC_Account (
                AC_ID
            )
            SELECT
                NEW.AC_ID
            WHERE NOT EXISTS(
	            SELECT
	                AC_ID 
	            FROM dbo.AC_Account
	            WHERE AC_ID = NEW.AC_ID
	            LIMIT 1
            );
        END IF;
        -- insert row into temporary table
    	INSERT INTO _tmp_it_AC_Account (
            AC_ID,
            AC_IDY_AC_ID,
            AC_IDY_Account_Identity,
            AC_FNA_AC_ID,
            AC_FNA_ChangedAt,
            AC_FNA_Account_Firstname,
            AC_LNA_AC_ID,
            AC_LNA_ChangedAt,
            AC_LNA_Account_Lastname
    	) VALUES (
    	    NEW.AC_ID,
            COALESCE(NEW.AC_IDY_AC_ID, NEW.AC_ID),
            NEW.AC_IDY_Account_Identity,
            COALESCE(NEW.AC_FNA_AC_ID, NEW.AC_ID),
            COALESCE(NEW.AC_FNA_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.AC_FNA_Account_Firstname,
            COALESCE(NEW.AC_LNA_AC_ID, NEW.AC_ID),
            COALESCE(NEW.AC_LNA_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.AC_LNA_Account_Lastname
    	);
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER iti_lAC_Account
INSTEAD OF INSERT ON dbo.lAC_Account
FOR EACH ROW
EXECUTE PROCEDURE dbo.iti_lAC_Account();
-- AFTER INSERT trigger ---------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS ita_lAC_Account ON dbo.lAC_Account;
DROP FUNCTION IF EXISTS dbo.ita_lAC_Account();
CREATE OR REPLACE FUNCTION dbo.ita_lAC_Account() RETURNS trigger AS '
    BEGIN
        INSERT INTO dbo.AC_IDY_Account_Identity (
            AC_IDY_AC_ID,
            AC_IDY_Account_Identity
        )
        SELECT
            i.AC_IDY_AC_ID,
            i.AC_IDY_Account_Identity
        FROM
            _tmp_it_AC_Account i
        WHERE
            i.AC_IDY_Account_Identity is not null;
        INSERT INTO dbo.AC_FNA_Account_Firstname (
            AC_FNA_AC_ID,
            AC_FNA_ChangedAt,
            AC_FNA_Account_Firstname
        )
        SELECT
            i.AC_FNA_AC_ID,
            i.AC_FNA_ChangedAt,
            i.AC_FNA_Account_Firstname
        FROM
            _tmp_it_AC_Account i
        WHERE
            i.AC_FNA_Account_Firstname is not null;
        INSERT INTO dbo.AC_LNA_Account_Lastname (
            AC_LNA_AC_ID,
            AC_LNA_ChangedAt,
            AC_LNA_Account_Lastname
        )
        SELECT
            i.AC_LNA_AC_ID,
            i.AC_LNA_ChangedAt,
            i.AC_LNA_Account_Lastname
        FROM
            _tmp_it_AC_Account i
        WHERE
            i.AC_LNA_Account_Lastname is not null;
        DROP TABLE IF EXISTS _tmp_it_AC_Account;
        RETURN NULL;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER ita_lAC_Account
AFTER INSERT ON dbo.lAC_Account
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.ita_lAC_Account();
-- BEFORE INSERT trigger --------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS itb_lRO_Role ON dbo.lRO_Role;
DROP FUNCTION IF EXISTS dbo.itb_lRO_Role();
CREATE OR REPLACE FUNCTION dbo.itb_lRO_Role() RETURNS trigger AS '
    BEGIN
        -- create temporary table to keep inserted rows in
        CREATE TEMPORARY TABLE IF NOT EXISTS _tmp_it_RO_Role (
            RO_ID int not null,
            RO_IDY_RO_ID int null,
            RO_IDY_Role_Identity uuid null,
            RO_NAM_RO_ID int null,
            RO_NAM_ChangedAt timestamp null,
            RO_NAM_Role_Name text null
        ) ON COMMIT DROP;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER itb_lRO_Role
BEFORE INSERT ON dbo.lRO_Role
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.itb_lRO_Role(); 
-- INSTEAD OF INSERT trigger ----------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS iti_lRO_Role ON dbo.lRO_Role;
DROP FUNCTION IF EXISTS dbo.iti_lRO_Role();
CREATE OR REPLACE FUNCTION dbo.iti_lRO_Role() RETURNS trigger AS '
    BEGIN
        -- generate anchor ID (if not provided)
        IF (NEW.RO_ID IS NULL) THEN 
            INSERT INTO dbo.RO_Role (
                RO_Dummy
            ) VALUES (
                null
            );
            SELECT
                lastval() 
            INTO NEW.RO_ID;
        -- if anchor ID is provided then let''s insert it into the anchor table
        -- but only if that ID is not present in the anchor table
        ELSE
            INSERT INTO dbo.RO_Role (
                RO_ID
            )
            SELECT
                NEW.RO_ID
            WHERE NOT EXISTS(
	            SELECT
	                RO_ID 
	            FROM dbo.RO_Role
	            WHERE RO_ID = NEW.RO_ID
	            LIMIT 1
            );
        END IF;
        -- insert row into temporary table
    	INSERT INTO _tmp_it_RO_Role (
            RO_ID,
            RO_IDY_RO_ID,
            RO_IDY_Role_Identity,
            RO_NAM_RO_ID,
            RO_NAM_ChangedAt,
            RO_NAM_Role_Name
    	) VALUES (
    	    NEW.RO_ID,
            COALESCE(NEW.RO_IDY_RO_ID, NEW.RO_ID),
            NEW.RO_IDY_Role_Identity,
            COALESCE(NEW.RO_NAM_RO_ID, NEW.RO_ID),
            COALESCE(NEW.RO_NAM_ChangedAt, CAST(LOCALTIMESTAMP AS timestamp)),
            NEW.RO_NAM_Role_Name
    	);
        RETURN NEW;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER iti_lRO_Role
INSTEAD OF INSERT ON dbo.lRO_Role
FOR EACH ROW
EXECUTE PROCEDURE dbo.iti_lRO_Role();
-- AFTER INSERT trigger ---------------------------------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS ita_lRO_Role ON dbo.lRO_Role;
DROP FUNCTION IF EXISTS dbo.ita_lRO_Role();
CREATE OR REPLACE FUNCTION dbo.ita_lRO_Role() RETURNS trigger AS '
    BEGIN
        INSERT INTO dbo.RO_IDY_Role_Identity (
            RO_IDY_RO_ID,
            RO_IDY_Role_Identity
        )
        SELECT
            i.RO_IDY_RO_ID,
            i.RO_IDY_Role_Identity
        FROM
            _tmp_it_RO_Role i
        WHERE
            i.RO_IDY_Role_Identity is not null;
        INSERT INTO dbo.RO_NAM_Role_Name (
            RO_NAM_RO_ID,
            RO_NAM_ChangedAt,
            RO_NAM_Role_Name
        )
        SELECT
            i.RO_NAM_RO_ID,
            i.RO_NAM_ChangedAt,
            i.RO_NAM_Role_Name
        FROM
            _tmp_it_RO_Role i
        WHERE
            i.RO_NAM_Role_Name is not null;
        DROP TABLE IF EXISTS _tmp_it_RO_Role;
        RETURN NULL;
    END;
' LANGUAGE plpgsql;
CREATE TRIGGER ita_lRO_Role
AFTER INSERT ON dbo.lRO_Role
FOR EACH STATEMENT
EXECUTE PROCEDURE dbo.ita_lRO_Role();
-- TIE TEMPORAL PERSPECTIVES ------------------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each tie. There are four types of perspectives: latest,
-- point-in-time, difference, and now.
--
-- The latest perspective shows the latest available information for each tie.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints.
--
-- intervalStart the start of the interval for finding changes
-- intervalEnd the end of the interval for finding changes
--
-- Under equivalence all these views default to equivalent = 0, however, corresponding
-- prepended-e perspectives are provided in order to select a specific equivalent.
--
-- equivalent the equivalent for which to retrieve data
--
-- DROP TIE TEMPORAL PERSPECTIVES ----------------------------------------------------------------------------------
/*
DROP VIEW IF EXISTS dbo.nAC_belongsTo_RO_has;
DROP FUNCTION IF EXISTS dbo.pAC_belongsTo_RO_has(
    timestamp without time zone
);
DROP VIEW IF EXISTS dbo.lAC_belongsTo_RO_has;
*/
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lAC_belongsTo_RO_has viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.lAC_belongsTo_RO_has AS
SELECT
    tie.AC_ID_belongsTo,
    tie.RO_ID_has
FROM
    dbo.AC_belongsTo_RO_has tie;
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pAC_belongsTo_RO_has viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION dbo.pAC_belongsTo_RO_has (
    changingTimepoint timestamp without time zone
)
RETURNS TABLE (
    AC_ID_belongsTo int,
    RO_ID_has int
) AS '
SELECT
    tie.AC_ID_belongsTo,
    tie.RO_ID_has
FROM
    dbo.AC_belongsTo_RO_has tie;
' LANGUAGE SQL;
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nAC_belongsTo_RO_has viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW dbo.nAC_belongsTo_RO_has AS
SELECT
    *
FROM
    dbo.pAC_belongsTo_RO_has(LOCALTIMESTAMP);
-- DESCRIPTIONS -------------------------------------------------------------------------------------------------------

