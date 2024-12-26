//
//  Container.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation
import Factory

// MARK: Framework Services

extension Container {
    
    var locationService: Factory<LocationService> {
        self { LocationService() }.singleton
    }
}

// MARK: Storage Files

extension Container {
    
    var storageDataSource: Factory<StorageFilesDataSource> {
        self { FirestoreStorageFilesDataSourceImpl() }.singleton
    }
}

// MARK: Authentication

extension Container {
    
    var authenticationDataSource: Factory<AuthenticationDataSource> {
        self { FirebaseAuthenticationDataSourceImpl() }.singleton
    }
    
    var authenticationRepository: Factory<AuthenticationRepository> {
        self { AuthenticationRepositoryImpl(authenticationDataSource: self.authenticationDataSource()) }.singleton
    }
    
    var signOutUseCase: Factory<SignOutUseCase> {
        self { SignOutUseCase(repository: self.authenticationRepository()) }
    }
        
    var sendOtpUseCase: Factory<SendOtpUseCase> {
        self { SendOtpUseCase(repository: self.authenticationRepository()) }
    }
        
    var verifySessionUseCase: Factory<VerifySessionUseCase> {
        self { VerifySessionUseCase(authRepository: self.authenticationRepository(), userProfileRepository: self.userProfileRepository()) }
    }
        
    var signInUseCase: Factory<SignInUseCase> {
        self { SignInUseCase(authRepository: self.authenticationRepository(), userProfileRepository: self.userProfileRepository()) }
    }
        
    var signUpUseCase: Factory<SignUpUseCase> {
        self { SignUpUseCase(authRepository: self.authenticationRepository(), userRepository: self.userProfileRepository()) }
    }
}

// MARK: Users

extension Container {
    
    var userMapper: Factory<UserMapper> {
        self { UserMapper() }.singleton
    }
    
    var createUserMapper: Factory<CreateUserMapper> {
        self { CreateUserMapper() }.singleton
    }
    
    var updateUserMapper: Factory<UpdateUserMapper> {
        self { UpdateUserMapper() }.singleton
    }
    
    var userDataSource: Factory<UserDataSource> {
        self { FirestoreUserDataSourceImpl() }.singleton
    }
        
    var userProfileRepository: Factory<UserRepository> {
        self { UserRepositoryImpl(userDataSource: self.userDataSource(), storageFilesDataSource: self.storageDataSource(), userMatchDataSource: self.userMatchDataSource(), userMapper: self.userMapper(), createUserMapper: self.createUserMapper(), updateUserMapper: self.updateUserMapper()) }.singleton
    }
        
    var updateUserUseCase: Factory<UpdateUserUseCase> {
        self { UpdateUserUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
        
    var getCurrentUserUseCase: Factory<GetCurrentUserUseCase> {
        self { GetCurrentUserUseCase(authRepository: self.authenticationRepository(), userRepository: self.userProfileRepository())}
    }
        
    var verifyUsernameAvailabilityUseCase: Factory<VerifyUsernameAvailabilityUseCase> {
        self { VerifyUsernameAvailabilityUseCase(userProfileRepository: self.userProfileRepository()) }
    }
        
    var getSuggestionsUseCase: Factory<GetSuggestionsUseCase> {
        self { GetSuggestionsUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var searchUsersUseCase: Factory<SearchUsersUseCase> {
        self { SearchUsersUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
}

// MARK: User Matches

extension Container {
    
    var userMatchDataSource: Factory<UserMatchDataSource> {
        self { FirestoreUserMatchDataSourceImpl() }.singleton
    }
    
    var getUserMatchesUseCase: Factory<GetUserMatchesUseCase> {
        self { GetUserMatchesUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var likeUserUseCase: Factory<LikeUserUseCase> {
        self { LikeUserUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var dislikeUserUseCase: Factory<DislikeUserUseCase> {
        self { DislikeUserUseCase(userRepository: self.userProfileRepository(), authRepository: self.authenticationRepository()) }
    }
}

// MARK: Messaging

extension Container {
    
    var createChatMapper: Factory<CreateChatMapper> {
        self { CreateChatMapper() }.singleton
    }
    
    var createChatMessageMapper: Factory<CreateChatMessageMapper> {
        self { CreateChatMessageMapper() }.singleton
    }
    
    var chatMapper: Factory<ChatMapper> {
        self { ChatMapper(userMapper: self.userMapper()) }.singleton
    }
    
    var chatMessageMapper: Factory<ChatMessageMapper> {
        self { ChatMessageMapper() }.singleton
    }
    
    var messagingDataSource: Factory<MessagingDataSource> {
        self { FirestoreMessagingDataSourceImpl() }.singleton
    }
    
    var messagingRepository: Factory<MessagingRepository> {
        self { MessagingRepositoryImpl(messagingDataSource: self.messagingDataSource(), userDataSource: self.userDataSource(), authDataSource: self.authenticationDataSource(), createChatMapper: self.createChatMapper(), createChatMessageMapper: self.createChatMessageMapper(), chatMapper: self.chatMapper(), chatMessageMapper: self.chatMessageMapper()) }.singleton
    }
    
    var createChatUseCase: Factory<CreateChatUseCase> {
        self { CreateChatUseCase(messagingRepository: self.messagingRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var getUserChatsUseCase: Factory<GetUserChatsUseCase> {
        self { GetUserChatsUseCase(messagingRepository: self.messagingRepository(), authRepository: self.authenticationRepository()) }
    }
    
    var getChatMessagesUseCase: Factory<GetChatMessagesUseCase> {
        self { GetChatMessagesUseCase(messagingRepository: self.messagingRepository()) }
    }
    
    var deleteChatUseCase: Factory<DeleteChatUseCase> {
        self { DeleteChatUseCase(messagingRepository: self.messagingRepository()) }
    }
    
    var deleteMessageUseCase: Factory<DeleteMessageUseCase> {
        self { DeleteMessageUseCase(messagingRepository: self.messagingRepository()) }
    }
    
    var deleteAllMessageUseCase: Factory<DeleteAllMessageUseCase> {
        self { DeleteAllMessageUseCase(messagingRepository: self.messagingRepository()) }
    }
    
    var createChatMessageUseCase: Factory<CreateChatMessageUseCase> {
        self { CreateChatMessageUseCase(messagingRepository: self.messagingRepository(), authRepository: self.authenticationRepository()) }
    }
}

// MARK: Reported users

extension Container {
    
    var reportUserMapper: Factory<ReportUserMapper> {
        self { ReportUserMapper() }.singleton
    }
    
    var reportedUsersDataSource: Factory<ReportedUsersDataSource> {
        self { FirestoreReportedUsersDataSourceImpl() }.singleton
    }
    
    var reportedUsersRepository: Factory<ReportedUsersRepository> {
        self { ReportedUsersRepositoryImpl(reportedUsersDataSource: self.reportedUsersDataSource(), reportUserMapper: self.reportUserMapper()) }.singleton
    }
    
    var reportUserUseCase: Factory<ReportUserUseCase> {
        self { ReportUserUseCase(reportedUsersDataSource: self.reportedUsersDataSource(), authRepository: self.authenticationRepository()) }.singleton
    }
}

// MARK: Utils

extension Container {
    
    var eventBus: Factory<EventBus<AppEvent>> {
        self { EventBus<AppEvent>() }.singleton
    }
}
