export default `
.station:before {
  content: ' ';
  display: inline-block;
  width: 35px;
  height: 35px;
  background: #009DE0;
  border-radius: 35px;
  margin: 0 12px 35px 0;
  vertical-align: top;
  box-shadow: 2px 2px 5px rgba(0,0,0,0.5);
}
.station {
  border-radius: 20px;
  padding: 12px 20px 12px 12px;
  color: transparent;
  line-height: 40px;
  font-size: 30px;
}
.station span {
  display: none;
}

.station span button {
  width: 100%;
  border: 1px solid;
  border-radius: 10px;
}
.station:hover {
  background: rgba(0,0,0,0.8);
  color: #fff;
  position: relative;
  z-index: 1;
}
.station:hover span {
  max-width: 500px;
  display: inline-block;
  position: relative;
  z-index: 1;
}
.out-of-range:before {
  background: #EF8A17;
  // background: #4AA4BF;
}
.within-range:before {
  background: #EF8A17;
  border: 4px solid #09814A;
  // background: #007090;
}
.found:before {
  background: #09814A;
  // background: #9AAFB7;
}
`;
