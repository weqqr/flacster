package tags

import "io"

func readUint32LE(r io.Reader) (uint32, error) {
	var data [4]byte

	_, err := io.ReadFull(r, data[:])
	if err != nil {
		return 0, err
	}

	a := uint32(data[0])
	b := uint32(data[1]) << 8
	c := uint32(data[2]) << 16
	d := uint32(data[3]) << 24

	return a | b | c | d, nil
}

func readUint32BE(r io.Reader) (uint32, error) {
	var data [4]byte

	_, err := io.ReadFull(r, data[:])
	if err != nil {
		return 0, err
	}

	a := uint32(data[0]) << 24
	b := uint32(data[1]) << 16
	c := uint32(data[2]) << 8
	d := uint32(data[3])

	return a | b | c | d, nil
}

func readExact(r io.Reader, len uint32) ([]byte, error) {
	data := make([]byte, len)
	_, err := io.ReadFull(r, data)

	return data, err
}
