// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract StekcitPlayground {
    uint256 currentUserId = 0;
    uint256 currentEventId = 0;

    mapping(address => StekcitUser) allUsers;
    mapping(address => uint256[]) eventIdsOfCreatingUser;
    mapping(uint256 => StekcitEvent) allEvents;

    struct StekcitUser {
        uint256 id;
        address userWalletAddress;
        string username;
    }

    struct StekcitEvent {
        uint256 id;
        address creatingUserWalletAddress;
    }

    function createUser(address _walletAddress, string memory username) public {
        uint256 newUserId = currentUserId;

        StekcitUser memory newUser = StekcitUser(
            newUserId,
            _walletAddress,
            username
        );

        allUsers[_walletAddress] = newUser;

        currentUserId++;
    }

    function getUser(address _walletAddress)
        public
        view
        returns (StekcitUser memory)
    {
        return allUsers[_walletAddress];
    }

    function updateUser(address _walletAddress, string memory newUsername)
        public
    {
        StekcitUser memory userToBeUpdated = allUsers[_walletAddress];
        userToBeUpdated.username = newUsername;
        allUsers[_walletAddress] = userToBeUpdated;
    }

    function createEvent(address _walletAddress) public {
        uint256 newEventId = currentEventId;

        StekcitEvent memory newEvent = StekcitEvent(newEventId, _walletAddress);

        allEvents[newEventId] = newEvent;

        uint256[] storage latestEventIdsOfCreatingUser = eventIdsOfCreatingUser[
            _walletAddress
        ];

        latestEventIdsOfCreatingUser.push(newEventId);

        eventIdsOfCreatingUser[_walletAddress] = latestEventIdsOfCreatingUser;

        currentEventId++;
    }

    function getNumberOfAllEvents() public view returns (uint256) {
        return currentEventId;
    }

    function getEventsOfCreatingUser(address _walletAddress)
        public
        view
        returns (StekcitEvent[] memory)
    {
        uint256[] storage allEventIdsOfCreatingUser = eventIdsOfCreatingUser[
            _walletAddress
        ];

        uint256 numberOfAllEvents = allEventIdsOfCreatingUser.length;

        StekcitEvent[] memory allEventsOfCreatingUser = new StekcitEvent[](
            numberOfAllEvents
        );

        for (
            uint256 eventIdLocationIndex = 0;
            eventIdLocationIndex < numberOfAllEvents;
            eventIdLocationIndex++
        ) {
            uint256 eventId = allEventIdsOfCreatingUser[eventIdLocationIndex];
            StekcitEvent memory currentEvent = allEvents[eventId];
            allEventsOfCreatingUser[eventIdLocationIndex] = currentEvent;
        }

        return allEventsOfCreatingUser;
    }

    function getAllCreatedEvents() public view returns (StekcitEvent[] memory) {
        uint256 countOfAllEvents = currentEventId;

        StekcitEvent[] memory allCreatedEvents = new StekcitEvent[](
            countOfAllEvents
        );

        for (uint256 eventId = 0; eventId < countOfAllEvents; eventId++) {
            StekcitEvent memory currentEvent = allEvents[eventId];
            allCreatedEvents[eventId] = currentEvent;
        }

        return allCreatedEvents;
    }

    // TO DO: Fix this
    function getAllUsers() public view returns (StekcitUser[] memory) {
        uint256 countOfAllUsers = currentUserId;

        StekcitUser[] memory allCreatedUsers = new StekcitUser[](
            countOfAllUsers
        );

        // for (uint256 userId = 0; userId < countOfAllUsers; userId++) {
        //     StekcitUser memory currentUser = allUsers[userId];
        //     allCreatedUsers[userId] = currentUser;
        // }

        return allCreatedUsers;
    }
}
