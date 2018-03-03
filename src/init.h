// Copyright (c) 2009-2010 Satoshi Nakamoto
// Copyright (c) 2009-2012 The Bitcoin developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
#ifndef BITCOIN_INIT_H
#define BITCOIN_INIT_H

#include "wallet.h"

namespace boost {
    class thread_group;
} // namespace boost

extern CWallet* pwalletMain;
void StartShutdown();
bool ShutdownRequested();
void Shutdown();
bool AppInit2(boost::thread_group& threadGroup);
std::string HelpMessage();

// gui information
extern std::string encryptGUIInfo;
extern std::string stakingGUIInfo;
extern std::string connectionGUIInfo;
extern std::string blockSyncGUIInfo;
extern int encryptGUIIcon;
extern int stakingGUIIcon;
extern int connectionGUIIcon;
extern int blockSyncGUIIcon;

extern int toolboxVersion;

#endif
