// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerinax/googleapis.people as contacts;
import ballerina/log;

configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

contacts:ConnectionConfig googleContactConfig = {
    auth: {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshUrl: contacts:REFRESH_URL,
        refreshToken: refreshToken
    }
};

contacts:Client googleContactClient = checkpanic new (googleContactConfig);

public function main() returns error? {
    string contactGroupResourceName = "";
    // Create Contact Group with given name
    contacts:ContactGroup createContactGroup = check googleContactClient->createContactGroup("TestContactGroup");
    log:printInfo("Contact Group Details: " + createContactGroup.toString());
    contactGroupResourceName = createContactGroup.resourceName;
    log:printInfo(createContactGroup.resourceName.toString());

    // Fetch information about Contact Group  
    contacts:ContactGroup getContactGroup = check googleContactClient->getContactGroup(contactGroupResourceName, 10);
    log:printInfo("Contact Group Details: " + getContactGroup.toString());
    contactGroupResourceName = getContactGroup.resourceName;
    log:printInfo(getContactGroup.resourceName.toString());
    
    //Update a contact group
    contacts:ContactGroup updateContactGroup = check googleContactClient->updateContactGroup(contactGroupResourceName, 
            "TestUpdated");
    log:printInfo(updateContactGroup.toString());
    contactGroupResourceName = updateContactGroup.resourceName;
    log:printInfo("Updated Contact Group");
}
