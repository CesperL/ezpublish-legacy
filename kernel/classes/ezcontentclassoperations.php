<?php
//
// Definition of eZContentClassOperations class
//
// Created on: <23-Jan-2006 13:25:46 vs>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ publish
// SOFTWARE RELEASE: 3.8.x
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 eZ systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*! \file ezcontentclassoperations.php
*/

/*!
  \class eZContentClassOperations ezcontentclassoperations.php
  \brief The class eZContentClassOperations is a place where
         content class operations are encapsulated.
  We move them out from eZContentClass because they may content code
  which is not directly related to content classes (e.g. clearing caches, etc).
*/

include_once( 'kernel/classes/ezcontentclass.php' );

class eZContentClassOperations
{
    /*!
     Removes content class and all data associated with it.
     \static
    */
    function remove( $classID )
    {
        $contentClass = eZContentClass::fetch( $classID );

        if ( !$contentClass->isRemovable() )
            return false;

        // Remove all objects of this class, fething them partially to avoid memory exhaustion.
        $db =& eZDB::instance();
        $classID = $contentClass->attribute( 'id' );
        while ( true )
        {
            $resArray = $db->arrayQuery( "SELECT ezcontentobject.id FROM ezcontentobject WHERE ezcontentobject.contentclass_id='$classID'", array( 'length' => 50 ) );
            if( !$resArray )
                break;

            foreach( $resArray as $row )
            {
                $objectID = $row['id'];
                include_once( 'kernel/classes/ezcontentobjectoperations.php' );
                eZContentObjectOperations::remove( $objectID );
            }
        }

        eZContentClassClassGroup::removeClassMembers( $classID, 0 );
        eZContentClassClassGroup::removeClassMembers( $classID, 1 );

        // Fetch real version and remove it
        $contentClass->remove( true );

        // Fetch temp version and remove it
        $tempDeleteClass = eZContentClass::fetch( $classID, true, 1 );
        if ( $tempDeleteClass != null )
            $tempDeleteClass->remove( true, 1 );

        return true;
    }
}


?>