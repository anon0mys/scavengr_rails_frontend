export default `
.station:before {
  content: ' ';
  display: inline-block;
  width: 35px;
  height: 35px;
  background: #18FFFF;
  border-radius: 35px;
  margin: 0 12px 35px 0;
  vertical-align: top;
}
.station {
  border-radius: 20px;
  padding: 12px 20px 12px 12px;
  color: transparent;
  line-height: 40px;
  font-size: 30px;
  white-space: nowrap;
}
.station span {
  display: none;
}
.station:hover {
  background: rgba(0,0,0,0.8);
  color: #fff;

}
.station:hover span {
  display: inline-block;
}
.out-of-range:before {
  background: red;
}
.within-range:before {
  background: green;
}
.found:before {
  background: blue;
}
`;
