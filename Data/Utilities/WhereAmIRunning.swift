//
//  WhereAmIRunning.swift
//  https://gist.github.com/mvarie/63455babc2d0480858da
//
//  ### Detects whether we're running in a Simulator, TestFlight Beta or App Store build ###
//
//  Based on https://github.com/bitstadium/HockeySDK-iOS/blob/develop/Classes/BITHockeyHelper.m
//  Inspired by http://stackoverflow.com/questions/18282326/how-can-i-detect-if-the-currently-running-app-was-installed-from-the-app-store
//  Created by marcantonio on 04/11/15.
//
import Foundation

class WhereAmIRunning {
    static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
}
