// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Attendance Logger on-chain
/// @notice Mencatat kehadiran (nama, timestamp, status) secara immutable di blockchain.
contract AttendanceLogger {
    enum Status { Hadir, TidakHadir }

    struct Record {
        uint256 id;
        string nama;
        uint256 waktu;     // unix timestamp dari block
        Status status;
        address pencatat;  // siapa yang memanggil fungsi (admin/guru/HR/siapapun)
    }

    uint256 public total; // jumlah record
    mapping(uint256 => Record) public records;

    event AttendanceLogged(
        uint256 indexed id,
        string nama,
        uint256 waktu,
        Status status,
        address indexed pencatat
    );

    /// @notice Mencatat data kehadiran ke blockchain.
    /// @param _nama Nama peserta (misal "Budi").
    /// @param _status 0 = Hadir, 1 = TidakHadir.
    function logAttendance(string calldata _nama, Status _status) external {
        uint256 id = ++total;
        records[id] = Record({
            id: id,
            nama: _nama,
            waktu: block.timestamp,
            status: _status,
            pencatat: msg.sender
        });
        emit AttendanceLogged(id, _nama, block.timestamp, _status, msg.sender);
    }

    /// @notice Ambil banyak record sekaligus (pagination sederhana).
    function getBatch(uint256 startId, uint256 count) external view returns (Record[] memory out) {
        require(startId >= 1 && startId <= total, "startId out of range");
        uint256 endId = startId + count - 1;
        if (endId > total) endId = total;
        uint256 n = endId - startId + 1;
        out = new Record[](n);
        for (uint256 i = 0; i < n; i++) {
            out[i] = records[startId + i];
        }
    }
}
